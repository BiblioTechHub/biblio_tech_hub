import 'package:biblio_tech_hub/presentation/blocs/cubit/user_cubit.dart';
import 'package:biblio_tech_hub/presentation/views/home_view.dart';
import 'package:biblio_tech_hub/presentation/views/loan_view.dart';
import 'package:biblio_tech_hub/presentation/views/profile_view.dart';
import 'package:biblio_tech_hub/presentation/views/search_view.dart';
import 'package:biblio_tech_hub/presentation/screens/sign_in_screen.dart';
import 'package:biblio_tech_hub/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.pageIndex});

  final int pageIndex;

  final viewRoutes = const <Widget> [
    HomeView(),
    SearchView(),
    LoanView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {

    if(context.watch<UserCubit>().state.isLogged == false 
        && context.watch<UserCubit>().state.isGuest == false){
      return const SignInScreen();
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
