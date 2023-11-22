import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final GoogleBookDatasource googleBookDatasource = GoogleBookDatasource();

  
  List<Book> listbooks = [];
  Book? searchResult; // Cambié List<Book> a Book
  Timer? _debounceTimer; // Nuevo: temporizador para la búsqueda después de la inactividad

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
