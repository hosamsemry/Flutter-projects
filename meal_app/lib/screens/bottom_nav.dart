import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

 void _selectScreen(String identifier) {
  Get.back();

  
  if (identifier == 'meals') {
    Get.offAll(() => const BottomNav());
  }
}


  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen();
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = FavoritesScreen();
      activePageTitle = 'Favs';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outlined),
            label: 'Favs',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
      ),
      drawer: MainDrawer(onSelectedScreen: _selectScreen),
      body: activePage,
    );
  }
}
