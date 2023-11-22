part of 'user_cubit.dart';

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
