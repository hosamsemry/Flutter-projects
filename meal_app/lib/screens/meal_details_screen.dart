import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controllers/meals_controller.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    MealsController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        // backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                controller.isFavorite(meal.id)
                    ? Icons.star_outlined
                    : Icons.star_outline,
                color: const Color.fromARGB(255, 255, 196, 0),
                size: 30,
              ),
            ),
            onPressed: () {
              controller.toggleFavorite(meal.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                "Ingrediants",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),

              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16),
                ),
              SizedBox(height: 20),
              Text(
                "Steps",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),

              for (final step in meal.steps)
                Text(
                  textAlign: TextAlign.start,
                  step,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
