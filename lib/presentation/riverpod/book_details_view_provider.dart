
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookDetailsViewProvider = StateNotifierProvider<BookStockNotifier, Book>((ref) {
  return BookStockNotifier();
});

class BookStockNotifier extends StateNotifier<Book> {
  BookStockNotifier() : super(Book.empty());

  void setBook(Book book) {
    state = book;
  }
}