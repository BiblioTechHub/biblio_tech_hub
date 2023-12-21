import 'package:biblio_tech_hub/domain/entities/book.dart';

abstract class BookDatasource {

  Future<Book> getBookByISBN(String isbn);

  Future<List<Book>> getBookDrama();

  Future<List<Book>> getBookByTitle(String title);

}