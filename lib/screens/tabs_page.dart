import 'package:fdgc08/data/dummy_data.dart';
import 'package:fdgc08/screens/categories_page.dart';
import 'package:fdgc08/screens/filters_page.dart';
import 'package:fdgc08/screens/meals_page.dart';
import 'package:fdgc08/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

const kInitialfilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() {
    return _TabsPageState();
  }
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialfilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal is marked as a favorite.');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersPage(
          currentFilters: _selectedFilters,),)
      );

      setState(() {
        _selectedFilters = result ?? kInitialfilters;
      });


    }
  }

  @override
  Widget build(BuildContext context) {

    final availableMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesPage(
        onToggleFavorite: _toggleMealFavoriteStatus,
    availableMeals: availableMeals,);
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsPage(meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoriteStatus);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
