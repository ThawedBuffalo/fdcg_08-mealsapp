import 'package:fdgc08/models/meal.dart';
import 'package:flutter/material.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key, required this.meals, required this.title});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Text('Uh oh, no meals found!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),),
          const SizedBox(height: 16,),
          Text('Select a different category...',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),)
        ],
      ),
    );

    if (meals.isEmpty) {
      content = ListView.builder(
          itemBuilder: (ctx, index) => Text(meals[index].title));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
