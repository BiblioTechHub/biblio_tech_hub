
import 'package:biblio_tech_hub/presentation/screens/home_screen.dart';
import 'package:biblio_tech_hub/presentation/screens/loan_screen.dart';
import 'package:biblio_tech_hub/presentation/screens/profile_screen.dart';
import 'package:biblio_tech_hub/presentation/screens/search_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/loan',
          builder: (context, state) => const LoanScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ]
    )
  ]
);