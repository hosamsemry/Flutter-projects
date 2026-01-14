import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals_screen.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        splashColor: category.color.withValues(alpha: 1),
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          final filteredMeals = dummyMeals.where((e)=>e.categories.contains(category.id)).toList();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals, onToggleFavorite: (Meal meal) {  },),
            ),
          );
        },
        child: Container(
          // margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [category.color, category.color.withValues(alpha: .7)],
            ),
          ),
          child: Text(
            category.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
