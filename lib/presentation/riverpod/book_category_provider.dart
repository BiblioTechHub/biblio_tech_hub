import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookCategoryProvider = StateNotifierProvider<BookCategoryNotifier, List<BookState>>((ref) {
  final googleRepository = ref.watch(googleRepositoryProvider);
  return BookCategoryNotifier(repository: googleRepository);
});

class BookCategoryNotifier extends StateNotifier<List<BookState>> {
  BookCategoryNotifier({required this.repository}) : super([]);

  final BookRepositoryImpl repository;
  final FirebaseFirestore db = FirebaseFirestore.instance;


  Future<void> getBook() async {
    List<BookState> booksState = [];
    final List<Book> books = await repository.getBookbyCategory('drama');

    for(var book in books){
      booksState.add(BookState(
        book: book, 
        isAvailable: true, 
        isBorrowed: true, 
        title: book.title
      ));
    }

    
    state = booksState;
  }
}



