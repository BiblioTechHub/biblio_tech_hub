
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/models/book_google.dart';

class BookMapper {
  static Book bookBDToEntity(BookGoogle bookdb) => Book(
    title: bookdb.booksDetails.title, 
    authors:  bookdb.booksDetails.authors, 
    publisher: bookdb.booksDetails.publisher, 
    publishedDate: bookdb.booksDetails.publishedDate, 
    description: bookdb.booksDetails.description, 
    isbn: bookdb.booksDetails.industryIdentifiers, 
    categories: bookdb.booksDetails.categories, 
    imageLinks: bookdb.booksDetails.imageLinks, 
    language: bookdb.booksDetails.language
  );
}