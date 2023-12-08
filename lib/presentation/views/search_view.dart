import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';


class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final GoogleBookDatasource googleBookDatasource = GoogleBookDatasource();
  ValueNotifier<dynamic> result = ValueNotifier(null);
  
  List<Book> listbooks = [];
  Book? searchResult; // Cambié List<Book> a Book
  Timer? _debounceTimer; // Nuevo: temporizador para la búsqueda después de la inactividad

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    // Obtener el valor del campo de texto del NFC
    List<int> payload = tag.data['ndef']['cachedMessage']['records'][0]['payload'];
    
    // Convertir el payload a una cadena de texto UTF-8
    String nfcText = utf8.decode(payload);

    // Extraer el número del texto (asumiendo que está después de "en")
    String isbn = nfcText.substring(nfcText.indexOf("en") + 2);

    // Imprimir el valor del ISBN
    print('Valor del NFC (ISBN): $isbn');

    final result = await googleBookDatasource.getBookByISBN(isbn);

    setState(() {
      searchResult = result;
    });

    // Detener la sesión NFC
    NfcManager.instance.stopSession();
  });
}


  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        NdefRecord.createMime(
            'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        NdefRecord.createExternal(
            'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'Tag is not ndef';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.067),
            const AppLogo(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            final result = await googleBookDatasource.getBookByISBN('9780134494166');

                              setState(() {
                                searchResult = result;
                              });
                          },
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            expands: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Buscar libros...',
                            ),
                            onChanged: (query) async {
                              // Manejar la lógica de búsqueda aquí
                              if (_debounceTimer != null && _debounceTimer!.isActive) {
                                _debounceTimer!.cancel();
                              }
                              _debounceTimer = Timer(const Duration(seconds: 2), () {
                                // Nuevo: realizar la búsqueda después de 2 segundos de inactividad
                                _searchBooks(query);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Tag Read'), onPressed: _tagRead),
                      ElevatedButton(
                    child: Text('Ndef Write'),
                      onPressed: _ndefWrite),
                      ElevatedButton(
                    child: Text('Ndef Write Lock'),
                      onPressed: _ndefWriteLock),
                ],
              ),
            ),
            Container(
              height: size.height * 0.688,
              color: Colors.white,
              child: searchResult != null
                  ? buildLibroCard(searchResult!)
                  : Container(), // Mostrar el Card solo si hay un resultado
            ),
          ],
        ),
      ),
    );
    
  }

  void _searchBooks(String query) async {
    final result = await googleBookDatasource.getBookByISBN("9780132350884");

    setState(() {
      searchResult = result;
    });

  
  }

  Widget buildLibroCard(Book book) {
    String truncatedDescription = book.description.length > 100
        ? '${book.description.substring(0, 100)}...'
        : book.description;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Image.network(
          book.imageLinks, // Usar la URL de la imagen si está presente
          width: 100,
          height: 140,
        ),
        title: Text(
          book.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${book.authors} - ${book.publishedDate}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              truncatedDescription,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
