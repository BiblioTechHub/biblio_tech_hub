import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key, 
    required this.currentIndex,
  });

  final int currentIndex;

  void onItemTapped( BuildContext context, int index ) {
    switch(index) {
      case 0:
        context.go('/home/0');
        break;

      case 1:
        context.go('/home/1');
        break;
      
      case 2:
        context.go('/home/2');
        break;

      case 3:
        context.go('/home/3');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color.fromARGB(150, 66, 12, 167),
      unselectedItemColor: Colors.black,
      backgroundColor: Color.fromARGB(159, 209, 204, 204),
      onTap: (value) => onItemTapped(context, value),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      iconSize: 30,
      currentIndex: currentIndex,
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
          icon: Icon(Icons.menu_book_rounded),
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