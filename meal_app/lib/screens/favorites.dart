import 'package:flutter/material.dart';
import 'package:meal_app/controllers/meals_controller.dart';
import 'package:get/get.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:meal_app/screens/meal_details_screen.dart';


class FavoritesScreen extends StatelessWidget {
  final MealsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favoriteMeals.isEmpty) {
        return const Center(
          child: Text('No favorites yet'),
        );
      }

      return ListView.builder(
        itemCount: controller.favoriteMeals.length,
        itemBuilder: (context, index) {
          final mealId = controller.favoriteMeals[index];
          final meal = dummyMeals.firstWhere((m) => m.id == mealId);
          return MealItem(
            meal: meal,
            onSelectMeal: (Meal meal) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MealDetailsScreen(
                    meal: meal,
                    onToggleFavorite: (Meal m) {
                      controller.toggleFavorite(m.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
