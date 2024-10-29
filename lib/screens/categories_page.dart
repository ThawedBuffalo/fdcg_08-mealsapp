import 'package:fdgc08/data/dummy_data.dart';
import 'package:fdgc08/screens/meals_page.dart';
import 'package:fdgc08/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  void _selectCategory(BuildContext buildContext, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      buildContext,
      MaterialPageRoute(
        builder: (ctx) => MealsPage(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
            position: Tween(
              begin: Offset(0, 0.3),
              end: Offset(0,0),
            ).animate(
                CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                ),
            ),

            child: child,),);
  }
}
