import 'package:biblio_tech_hub/presentation/riverpod/book_isbn_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:biblio_tech_hub/presentation/blocs/user_cubit/user_cubit.dart';
import 'package:biblio_tech_hub/presentation/views/views.dart';
import 'package:biblio_tech_hub/presentation/screens/screens.dart';
import 'package:biblio_tech_hub/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    ref.read(bookStockProvider.notifier).getBook();
    ref.read(bookIsbnProvider.notifier).getBook();
  }

  @override
  Widget build(BuildContext context) {   

    final book = ref.watch(bookIsbnProvider);   

    final viewRoutes = <Widget> [
    // HomeView(),
    BookInfoView(book: book),
    SearchView(),
    LoanView(),
    ProfileView()
  ];

    if(context.watch<UserCubit>().state.isLogged == false 
        && context.watch<UserCubit>().state.isGuest == false){
      return const SignInScreen();
    }

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const BookBackground(),
          IndexedStack(
            index: widget.pageIndex,
            children: viewRoutes,
          ),
        ],
        
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: widget.pageIndex),
    );
  }
}
