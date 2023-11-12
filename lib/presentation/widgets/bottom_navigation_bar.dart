import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
  });

  void onItemTapped( BuildContext context, int index ) {
    switch(index) {
      case 0:
        context.go('/search');
        break;
      
      case 1:
        context.go('/loan');
        break;

      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      items: const [
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