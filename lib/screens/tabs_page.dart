import 'package:fdgc08/providers/favorites_provider.dart';
import 'package:fdgc08/screens/categories_page.dart';
import 'package:fdgc08/screens/filters_page.dart';
import 'package:fdgc08/screens/meals_page.dart';
import 'package:fdgc08/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

const kInitialfilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() {
    return _TabsPageState();
  }
}

class _TabsPageState extends ConsumerState<TabsPage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (ctx) => FiltersPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesPage(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsPage(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
