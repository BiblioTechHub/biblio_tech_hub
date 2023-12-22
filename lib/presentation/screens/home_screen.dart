// import 'package:biblio_tech_hub/presentation/riverpod/book_isbn_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';
import 'package:flutter/material.dart';

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
    Future(() => ref.read(bookStockProvider.notifier).getBook());

  }
  

  @override
  Widget build(BuildContext context) {   

    final viewRoutes = <Widget> [
    const HomeView(),
    const SearchView(),
    const LoanView(),
    const ProfileView(),
    // const BookDetailsView()
  ];

    if(ref.watch(userProvider).isLogged == false 
        && ref.watch(userProvider).isGuest == false){
      return const SignInScreen();
    }

    return Scaffold(
      extendBody: false,
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
