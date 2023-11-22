

import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/domain/repositories/book_repository.dart';
import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';

class BookRepositoryImpl extends BookRepository{

  @override
  Future<Book> getBookByISBN(String isbn) {
    return GoogleBookDatasource().getBookByISBN(isbn);
  }

  @override
  Future<Book> getBookByTitle(String title) {
    return GoogleBookDatasource().getBookByTitle(title);
  }

}