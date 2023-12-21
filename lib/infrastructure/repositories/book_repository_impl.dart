

import 'package:biblio_tech_hub/domain/datasources/book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/domain/repositories/book_repository.dart';
import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';

class BookRepositoryImpl extends BookRepository{

  final BookDatasource datasource;

  BookRepositoryImpl(this.datasource);

  @override
  Future<Book> getBookByISBN(String isbn) {
    return datasource.getBookByISBN(isbn);
  }
  
  @override
  Future<List<Book>> getBookDrama() async {
    List<Book> books = await datasource.getBookDrama();

    return books;
  }

  @override
  Future<List<Book>> getBookByTitle(String title) {
    return GoogleBookDatasource().getBookByTitle(title);
  }

}