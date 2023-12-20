
import 'package:biblio_tech_hub/infrastructure/services/google_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState(user: null, isLogged: false, isGuest: false));

  void signIn(User? user, bool isLogged){
    state = state.copyWith(
      user: user,
      isLogged: isLogged,
      isGuest: !isLogged
    );
  }

  void signOut(){
    GoogleServices.signOut();
    state = state.copyWith(
      user: null,
      isLogged: false,
      isGuest: false
    );
  }
}

class UserState extends Equatable{

  final User? user;
  final bool isLogged;
  final bool isGuest;

  const UserState({
    required this.user,
    this.isLogged = false,
    this.isGuest = false
  });

  copyWith({
    required User? user,
    required bool isLogged,
    required bool isGuest
  }) => UserState(    
    user: user,
    isLogged: isLogged,
    isGuest: isGuest
  );
  
  @override
  List<Object?> get props => [user, isLogged, isGuest];
  
}