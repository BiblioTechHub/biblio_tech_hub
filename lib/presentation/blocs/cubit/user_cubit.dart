import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState(id: '', email: ''));
}
