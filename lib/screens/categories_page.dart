import 'package:fdgc08/data/dummy_data.dart';
import 'package:fdgc08/screens/meals_page.dart';
import 'package:fdgc08/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _selectCategory(BuildContext buildContext) {
    Navigator.push(buildContext,
        MaterialPageRoute(builder: (ctx) => const MealsPage(
          title: 'title',
          meals: [],)));
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
                    _selectCategory(context);
              },)
          ],
        ),
    );
  }
}
