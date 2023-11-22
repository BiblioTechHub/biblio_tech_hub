


import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookIsbnProvider = StateNotifierProvider<BookStockNotifier, Book>((ref) {
  final googleRepository = ref.watch(googleRepositoryProvider).getBookByISBN('9780132350884');
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

  Future<Book> repository;

  Future<void> getBook() async {
    final books = await repository;
    state = books;
  }
}