
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/google_repository_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loansUserProvider = StateNotifierProvider<LoansNotifier, List<LoanState>>((ref) {
  final String? email = ref.watch(userProvider).user?.email;
  final BookRepositoryImpl googleRepository = ref.watch(googleRepositoryProvider);
  return LoansNotifier(email: email, repository: googleRepository);
});

class LoansNotifier extends StateNotifier<List<LoanState>> {
  LoansNotifier({required this.email, required this.repository}): super([]);

  final String? email;
  final BookRepositoryImpl repository;
  final FirebaseFirestore db = FirebaseFirestore.instance; 
  
  Future<void> getloans() async {

    int size = state.length;

    final querySnapshot = db.collection('user').where('email', isEqualTo: email);
    
    querySnapshot.snapshots().listen((event) async {

      final QuerySnapshot users = await db.collection('user').where('email', isEqualTo: email).get();

      if(users.docs.isNotEmpty) {
        size = users.docs.first['loans'].length;

        if(event.docs.first['loans'].length == size){
          for(var loan in event.docs.first['loans']){
            final LoanState loanState = LoanState(
              book: await repository.getBookByISBN(loan['isbn']), 
              loanDate: loan['F. Prestamo'], 
              expirationDate: loan['F. Vencimiento']
            );
            
            if(state.any((element) => element.book.isbn == loan['isbn'])){
              final int index = state.indexWhere((element) => element.book.isbn == loan["isbn"]);
              state[index] = loanState;
              state = [...state];
            }else{
              state = [...state, loanState];
            }
          }
        }else if(event.docs.first['loans'].length < size){ 
          List<LoanState> loans = [];
          for(var loan in event.docs.first['loans']){
            final LoanState loanState = LoanState(
              book: await repository.getBookByISBN(loan['isbn']), 
              loanDate: loan['F. Prestamo'], 
              expirationDate: loan['F. Vencimiento']
            );
            loans.add(loanState);
          }
          state = [...loans];
        }else if(event.docs.first['loans'].length > size) {
          final LoanState loanState = LoanState(
            book: await repository.getBookByISBN(event.docs.first['loans'].last['isbn']), 
            loanDate: event.docs.first['loans'].last['F. Prestamo'], 
            expirationDate: event.docs.first['loans'].last['F. Vencimiento']
          );
          state = [...state, loanState];
        }
      } else { state = []; }

      
    });
  }

  Future<void> makeLoan(BookState bookState) async {

    DateTime dateTime = DateTime.now();
    
    QuerySnapshot userCollection = await db.collection('user').where('email', isEqualTo: email).get();
    late DocumentSnapshot userDocument;
    
    if(userCollection.docs.isEmpty){
      await db.collection('user').add({'email': email, 'loans': []});
      userCollection = await db.collection('user').where('email', isEqualTo: email).get();
      userDocument = userCollection.docs.first;
    }

    final Map<String, dynamic> loan = {
     'isbn': bookState.book.isbn,
      'F. Prestamo': Timestamp.fromDate(dateTime),
      'F. Vencimiento': Timestamp.fromDate(dateTime.add(const Duration(days: 10)))
    };
    userDocument = userCollection.docs.first;
    await userDocument.reference.update({'loans': [...userDocument['loans'], loan]});


    QuerySnapshot bookCollection = await db.collection('book').where('isbn', isEqualTo: bookState.book.isbn).get();
    DocumentSnapshot bookDocument = bookCollection.docs.first;
    await bookDocument.reference.update({'isBorrowed': true});
  }

  Future<void> giveBackLoan(BookState bookState) async {
    QuerySnapshot userCollection = await db.collection('user').where('email', isEqualTo: email).get();
    DocumentSnapshot userDocument = userCollection.docs.first;

    List<Map<String, dynamic>> loans = [];
    for(var loan in state){
      if(loan.book.isbn != bookState.book.isbn){
        loans.add({
          'isbn': loan.book.isbn,
          'F. Prestamo': loan.loanDate,
          'F. Vencimiento': loan.expirationDate
        });
      }
    }

    await userDocument.reference.update({'loans': loans});


    QuerySnapshot bookCollection = await db.collection('book').where('isbn', isEqualTo: bookState.book.isbn).get();
    DocumentSnapshot bookDocument = bookCollection.docs.first;
    await bookDocument.reference.update({'isBorrowed': false});
  }

  Future<void> extendLoan(BookState bookState) async {
    QuerySnapshot userCollection = await db.collection('user').where('email', isEqualTo: email).get();
    DocumentSnapshot userDocument = userCollection.docs.first;

    List<Map<String, dynamic>> loans = [];
    for(var loan in state){
      if(loan.book.isbn == bookState.book.isbn){
        loans.add({
          'isbn': loan.book.isbn,
          'F. Prestamo': loan.loanDate,
          'F. Vencimiento': Timestamp.fromDate(loan.expirationDate.toDate().add(const Duration(days: 5)))
        });
      } else {
        loans.add({
          'isbn': loan.book.isbn,
          'F. Prestamo': loan.loanDate,
          'F. Vencimiento': loan.expirationDate
        });
      }
    }

    await userDocument.reference.update({'loans': loans});
  }

  String? getExpirationDate(String isbn){
    for(LoanState loan in state){
      if(loan.book.isbn == isbn){
        DateTime dateTime = loan.expirationDate.toDate();
        return '${dateTime.day+1}/${dateTime.month}/${dateTime.year}';
      } else {
      }
    }
    return null;
  }
}

class LoanState {
  final Book book;
  final Timestamp loanDate;
  final Timestamp expirationDate;

  const LoanState({
    required this.book,
    required this.loanDate,
    required this.expirationDate
  });
}