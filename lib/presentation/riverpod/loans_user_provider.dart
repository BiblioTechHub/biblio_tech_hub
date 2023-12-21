
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loansUserProvider = StateNotifierProvider<loansNotifier, List<loanState>>((ref) {
  final String? email = ref.watch(userProvider).user?.email;
  final BookRepositoryImpl googleRepository = ref.watch(googleRepositoryProvider);
  return loansNotifier(email: email, repository: googleRepository);
});

class loansNotifier extends StateNotifier<List<loanState>> {
  loansNotifier({required this.email, required this.repository}): super([]);

  final String? email;
  final BookRepositoryImpl repository;
  
  Future<void> getloans() async {

    final FirebaseFirestore db = FirebaseFirestore.instance; 
    // final List<Book> books =  [];

    await db.collection('user')
      .where('email', isEqualTo: email)
      .get()
      .then((value) async { 
        for(var doc in value.docs.first.data()['loans']){
          final loanState loan;
          loan = loanState(
            book: await repository.getBookByISBN(doc['isbn']), 
            loanDate: doc['F. Prestamo'], 
            expirationDate: doc['F. Vencimiento']
          );
          state = [...state, loan];
        }
        
      });
  }
}

class loanState {
  final Book book;
  // final String isbn;
  final Timestamp loanDate;
  final Timestamp expirationDate;

  const loanState({
    required this.book,
    // required this.isbn,
    required this.loanDate,
    required this.expirationDate
  });
}