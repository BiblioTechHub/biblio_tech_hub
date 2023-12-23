import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  List<Book> books = [];
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.067),
                const AppLogo(),
                SizedBox(height: size.height * 0.02),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal:20),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Buscar libros...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      filled: true,
                      fillColor: Colors.white
                    ),
                    onChanged: (query) {
                      _debounceTimer?.cancel();
            
                      _debounceTimer = Timer(const Duration(seconds: 2), () {
                        if(query != '') _searchBooks(query);
                      });
                    },
                  ),
                ),
              ]
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return _CardBook(book: books[index], size: size);
              },
            ),
          ),
        ]
      ),
      floatingActionButton: nfcButton()
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
        books.clear();
        books.add(result);
      });
    
      NfcManager.instance.stopSession();

    });
  }

  void _searchBooks(String query) async {
    final result = await googleBookDatasource.getBookByTitle(query);

    setState(() {
      books = result;
    });
  }

  Widget nfcButton() {
  return FloatingActionButton(
    onPressed: _tagRead, // Llamamos directamente a la función de lectura
    tooltip: 'Tag Read',
    child: Image.asset(
      'assets/logo_nfc.png',
      width: 36.0,
      height: 36.0,
    ),
  );
}

}


class _CardBook extends ConsumerWidget {
  const _CardBook({required this.book, required this.size});

  final Book book;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  book.imageLinks == ''
                  ? Image.asset(
                      'assets/default_imagen_book.png',
                      height: size.height * 0.13,
                    )
                  : Image.network(
                      book.imageLinks,
                      height: size.height * 0.13,
                    ),

                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${book.authors} - ${book.publishedDate}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          book.description, 
                          overflow: TextOverflow.ellipsis, 
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
      onTap: () async {
        ref.read(bookDetailsViewProvider.notifier).setBook(book);
        context.push('/home/0/book/${1}');
      },
    );
  }
}
