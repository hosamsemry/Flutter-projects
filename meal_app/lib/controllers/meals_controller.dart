import 'package:get/get.dart';

class MealsController extends GetxController {
  var favoriteMeals = <String>[].obs;

  bool isFavorite(String mealId) {
    return favoriteMeals.contains(mealId);
  }

  void toggleFavorite(String mealId) {
    if (favoriteMeals.contains(mealId)) {
      favoriteMeals.remove(mealId);
      Get.snackbar(
        'Removed',
        'Meal removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      favoriteMeals.add(mealId);
      Get.snackbar(
        'Added',
        'Meal added to favorites',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
