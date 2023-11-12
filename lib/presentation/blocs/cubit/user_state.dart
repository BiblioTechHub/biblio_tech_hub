part of 'user_cubit.dart';

class UserState extends Equatable{

  final User? user;

  const UserState({
    required this.user
  });

  copyWith({
    User? user
  }) => UserState(
    user: user ?? this.user
  );
  
  @override
  // TODO: implement props
  List<Object?> get props => [user];
  
}
