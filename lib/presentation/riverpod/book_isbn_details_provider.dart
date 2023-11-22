


import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookIsbnDetailsProvider = StateNotifierProvider<BookStockNotifier, Book>((ref) {
  final googleRepository = ref.watch(googleRepositoryProvider);
  return BookStockNotifier(repository: googleRepository);
});

class BookStockNotifier extends StateNotifier<Book> {
  BookStockNotifier({required this.repository}) 
  : super(Book(title: '', 
    authors: [], 
    publisher: '', 
    publishedDate: '', 
    description: '', 
    isbn: '', 
    categories: [], 
    imageLinks: '', 
    language: '', 
    pageCount: 0
  ));

  BookRepositoryImpl repository;

  Future<void> getBook(String isbn) async {
    final book = await repository.getBookByISBN(isbn);
    state = book;
  }
}