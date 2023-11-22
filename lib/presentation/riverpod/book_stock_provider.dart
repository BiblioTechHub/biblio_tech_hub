


import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookStockProvider = StateNotifierProvider<BookStockNotifier, List<Book>>((ref) {
  final googleRepository = ref.watch(googleRepositoryProvider).getBookDrama();
  return BookStockNotifier(repository: googleRepository);
});

class BookStockNotifier extends StateNotifier<List<Book>> {
  BookStockNotifier({required this.repository}) : super([]);

  Future<List<Book>> repository;

  Future<void> getBook() async {
    final books = await repository;
    state = books;
  }
}