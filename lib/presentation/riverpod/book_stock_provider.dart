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
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Future<void> getBook() async {
  //   final querySnapshot = await db.collection('book').get();
  //   querySnapshot.docs.first.reference.snapshots().listen((event) async {
  //     final book = await repository.getBookByISBN(event["isbn"]);
  //       final bookState = BookState(
  //         book: book, 
  //         isAvailable: event["isAvailable"], 
  //         isBorrowed: event["isBorrowed"], 
  //         title: event["title"]
  //       );
  //     state = [bookState];
  //   });
  //   for(var doc in querySnapshot.docs){
  //     doc.reference.snapshots().listen((event) async {        
  //       final book = await repository.getBookByISBN(event["isbn"]);
  //       final bookState = BookState(
  //         book: book, 
  //         isAvailable: event["isAvailable"], 
  //         isBorrowed: event["isBorrowed"], 
  //         title: event["title"]
  //       );

  //       if(state.any((element) => element.book.isbn == doc.data()["isbn"])){
  //         final int index = state.indexWhere((element) => element.book.isbn == doc.data()["isbn"]);
  //         state[index] = bookState;
  //         print(state[index]);
  //       }else{
  //         state = [...state, bookState];
  //       }
  //     });
  //   }
  // }

  Future<void> getBook() async {
    final querySnapshot = await db.collection('book').get();
    for(var doc in querySnapshot.docs){
      doc.reference.snapshots().listen((event) async {        
        final book = await repository.getBookByISBN(event["isbn"]);
        final bookState = BookState(
          book: book, 
          isAvailable: event["isAvailable"], 
          isBorrowed: event["isBorrowed"], 
          title: event["title"]
        );

        // state.map((e) => null)

        if(state.any((element) => element.book.isbn == doc.data()["isbn"])){
          final int index = state.indexWhere((element) => element.book.isbn == doc.data()["isbn"]);
          state[index] = bookState;
          state = [...state];
        }else{
          state = [...state, bookState];
        }
      });
    }
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