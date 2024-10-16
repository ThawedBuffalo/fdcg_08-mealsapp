import 'package:fdgc08/data/dummy_data.dart';
import 'package:fdgc08/screens/meals_page.dart';
import 'package:fdgc08/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _selectCategory(BuildContext buildContext, Category category) {
    final filteredMeals = dummyMeals
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select category...'),
      ),
      body: GridView(
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
    );
  }
}
