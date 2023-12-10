import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
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
  bool isNFCButtonActive = false;

  List<Book> listbooks = [];
  Book? searchResult;
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                                final result =
                                    await googleBookDatasource.getBookByISBN('9780134494166');

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
                                  if (_debounceTimer != null &&
                                      _debounceTimer!.isActive) {
                                    _debounceTimer!.cancel();
                                  }
                                  _debounceTimer = Timer(
                                    const Duration(seconds: 2),
                                    () {
                                      _searchBooks(query);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.688,
                  color: Colors.white,
                  child: searchResult != null
                      ? buildLibroCard(searchResult!)
                      : Container(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isNFCButtonActive = !isNFCButtonActive;
                });
              },
              child: Image.asset(
                'assets/logo_nfc.png',
                width: 36.0,
                height: 36.0,
              ),
            ),
          ),
          if (isNFCButtonActive) ...[
            Positioned(
              bottom: 72.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: _tagRead,
                child: const Text('Tag Read'),
              ),
            ),
            Positioned(
              bottom: 128.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  String isbnToWrite = '9780134494166';
                  _ndefWrite(isbnToWrite);
                },
                child: const Text('Tag Write'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      List<int> payload =
          tag.data['ndef']['cachedMessage']['records'][0]['payload'];

      String nfcText = utf8.decode(payload);

      String isbn = nfcText.substring(nfcText.indexOf("en") + 2);

      final result = await googleBookDatasource.getBookByISBN(isbn);

      setState(() {
        searchResult = result;
      });

      NfcManager.instance.stopSession();
    });
  }

  void _ndefWrite(String isbn) {
  NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    var ndef = Ndef.from(tag);
    if (ndef == null || !ndef.isWritable) {
      result.value = 'Tag is not ndef writable';
      NfcManager.instance.stopSession(errorMessage: result.value);
      return;
    }

    NdefMessage message = NdefMessage([
      NdefRecord.createText(isbn),
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
          book.imageLinks,
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
