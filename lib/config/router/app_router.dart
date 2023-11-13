
import 'package:biblio_tech_hub/presentation/screens/home_screen.dart';
import 'package:biblio_tech_hub/presentation/views/loan_view.dart';
import 'package:biblio_tech_hub/presentation/views/profile_view.dart';
import 'package:biblio_tech_hub/presentation/views/search_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
    )
  ]
);