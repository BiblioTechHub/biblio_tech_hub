import 'package:biblio_tech_hub/infrastructure/services/google_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(user: null, isLogged: false, isGuest: false));

  void signIn(User? user, bool isLogged){
    emit(state.copyWith(
      user: user,
      isLogged: isLogged,
      isGuest: !isLogged
    ));
  }

  void signOut(){
    GoogleServices.signOut();
    emit(state.copyWith(
      user: null,
      isLogged: false,
      isGuest: false
    ));
  }
}
