import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
  });

  void onItemTapped( BuildContext context, int index ) {
    switch(index) {
      case 0:
        context.go('/home');
        break;

      case 1:
        context.go('/home/search');
        break;
      
      case 2:
        context.go('/home/loan');
        break;

      case 3:
        context.go('/home/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Buscar'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_sharp),
          label: 'Préstamos'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Perfil'
        ),
      ]
    );
  }
}