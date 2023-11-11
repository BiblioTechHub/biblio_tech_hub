part of 'user_cubit.dart';

class UserState extends Equatable{

  final String id;
  final String email;

  const UserState({
    required this.id, 
    required this.email
  });

  copyWith({
    String? id,
    String? email 
  }) => UserState(
    id: id ?? this.id, 
    email: email ?? this.email
  );
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, email];
  
}
