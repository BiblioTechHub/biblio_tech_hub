import 'package:biblio_tech_hub/domain/entities/book.dart';

abstract class BookRepository {

  Future<Book> getBookByISBN(String isbn);

  Future<List<Book>> getBookDrama();
  
}