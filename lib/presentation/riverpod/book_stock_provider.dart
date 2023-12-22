import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookStockProvider = StateNotifierProvider<BookStockNotifier, List<BookState>>((ref) {
  final googleRepository = ref.watch(googleRepositoryProvider);
  return BookStockNotifier(repository: googleRepository);
});

class BookStockNotifier extends StateNotifier<List<BookState>> {
  BookStockNotifier({required this.repository}) : super([]);

  final BookRepositoryImpl repository;
  
  Future<void> getBook() async {

    final FirebaseFirestore db = FirebaseFirestore.instance; 
    // final List<Book> books =  [];

    await db.collection('book')
      .get()
      .then((value) async { 
        for(var doc in value.docs){
          // state = [...state, loan];
          print(doc.data());
          final book = await repository.getBookByISBN(doc.data()["isbn"]);
          final bookState = BookState(
            book: book, 
            isAvailable: doc.data()["isAvailable"], 
            isBorrowed: doc.data()["isBorrowed"], 
            title: doc.data()["title"]
          );
          state = [...state, bookState];
        }
        
      });
  }
}

class BookState {
  final Book book;
  final bool isAvailable;
  final bool isBorrowed;
  final String title;

  const BookState({
    required this.book,
    required this.isAvailable,
    required this.isBorrowed,
    required this.title
  });
}