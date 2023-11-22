
import 'package:biblio_tech_hub/presentation/riverpod/book_isbn_details_provider.dart';
import 'package:biblio_tech_hub/presentation/screens/home_screen.dart';
import 'package:biblio_tech_hub/presentation/views/views.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    ),
    GoRoute(
      path: '/book/:isbn',
      builder: (context, state) {
        final isbn = int.parse(state.pathParameters['isbn'] ?? '');
        return BookInfoView(isbn: isbn);
      },
    )
  ]
);