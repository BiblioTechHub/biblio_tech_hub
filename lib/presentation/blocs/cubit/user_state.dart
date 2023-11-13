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
    User? user,
    bool? isLogged,
    bool? isGuest
  }) => UserState(    
    user: user ?? this.user,
    isLogged: isLogged ?? this.isLogged,
    isGuest: isGuest ?? this.isGuest
  );
  
  @override
  List<Object?> get props => [user, isLogged, isGuest];
  
}
