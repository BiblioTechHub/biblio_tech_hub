import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(user: null, isLogged: false));

  void signIn(User user){
    emit(state.copyWith(
      user: user,
      isLogged: true
    ));
  }

  void signOut(){
    emit(state.copyWith(
      user: null,
      isLogged: false
    ));
  }
}
