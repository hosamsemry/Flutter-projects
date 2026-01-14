import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../controllers/filters_controller.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  final FiltersController filtersController =
      Get.find<FiltersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Obx(() {
        final filteredMeals = meals.where((meal) {
          if (filtersController.filters[Filter.glutenFree]! &&
              !meal.isGlutenFree) {
            return false;
          }
          if (filtersController.filters[Filter.lactoseFree]! &&
              !meal.isLactoseFree) {
            return false;
          }
          if (filtersController.filters[Filter.vegan]! &&
              !meal.isVegan) {
            return false;
          }
          if (filtersController.filters[Filter.vegetarian]! &&
              !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();

        return ListView.builder(
          itemCount: filteredMeals.length,
          itemBuilder: (ctx, index) {
            final meal = filteredMeals[index];
            return MealItem(
              meal: meal,
              onSelectMeal: (meal) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MealDetailsScreen(
                      meal: meal,
                      onToggleFavorite: onToggleFavorite,
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
