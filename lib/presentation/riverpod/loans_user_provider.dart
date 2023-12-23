
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
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

    //TODO: Quizas pueda ser almacenando aqui el estado
    int size = state.length;

    final querySnapshot = db.collection('user').where('email', isEqualTo: email);
    await querySnapshot.get().then((value) {
        size = value.docs.first['loans'].length;
    });
    
    querySnapshot.snapshots().listen((event) async {


      int len = event.docs.first['loans'].length;
      //TODO: Tenemos que comprobar que al quitar una reserva esta se actualize en el estado
      if(event.docs.first['loans'].length == size){
        for(var loan in event.docs.first['loans']){
          final LoanState loanState = LoanState(
            book: await repository.getBookByISBN(loan['isbn']), 
            loanDate: loan['F. Prestamo'], 
            expirationDate: loan['F. Vencimiento']
          );
          
          // TODO: comprobar si size == len
          if(state.any((element) => element.book.isbn == loan['isbn'])){
            final int index = state.indexWhere((element) => element.book.isbn == loan["isbn"]);
            state[index] = loanState;
            state = [...state];
          }else{
            state = [...state, loanState];
          }
        }
      }else{ 
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
      }
    });
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