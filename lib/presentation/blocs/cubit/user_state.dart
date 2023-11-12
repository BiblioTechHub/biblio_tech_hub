part of 'user_cubit.dart';

class UserState extends Equatable{

  final User? user;
  final bool isLogged;

  const UserState({
    required this.user,
    this.isLogged = false
  });

  copyWith({
    User? user,
    bool? isLogged
  }) => UserState(
    user: user ?? this.user,
    isLogged: isLogged ?? this.isLogged
  );
  
  @override
  // TODO: implement props
  List<Object?> get props => [user];
  
}
