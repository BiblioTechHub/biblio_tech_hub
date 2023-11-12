import 'package:biblio_tech_hub/presentation/blocs/cubit/user_cubit.dart';
import 'package:biblio_tech_hub/presentation/screens/sign_in_screen.dart';
import 'package:biblio_tech_hub/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    if(context.watch<UserCubit>().state.isLogged == false 
        && context.watch<UserCubit>().state.isGuest == false){
      return const SignInScreen();
    }

    return const Scaffold(
      body: Center(
        child: Text('Hola'),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
