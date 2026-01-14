import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controllers/filters_controller.dart';
import 'package:meal_app/screens/bottom_nav.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreens extends StatelessWidget {
  const FiltersScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersController = Get.find<FiltersController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      drawer: MainDrawer(
        onSelectedScreen: (identifier) {
          Get.back();
          if (identifier == 'meals') {
            Get.offAll(() => const BottomNav());
          }
        },
      ),
      body: Obx(
        () => Column(
          children: [
            customSwitch(
              'Gluten-free',
              'No gluten',
              filtersController.isActive(Filter.glutenFree),
              (val) => filtersController.setFilter(Filter.glutenFree, val),
            ),
            customSwitch(
              'Lactose-free',
              'No lactose',
              filtersController.isActive(Filter.lactoseFree),
              (val) => filtersController.setFilter(Filter.lactoseFree, val),
            ),
            customSwitch(
              'Vegan',
              'Only vegan',
              filtersController.isActive(Filter.vegan),
              (val) => filtersController.setFilter(Filter.vegan, val),
            ),
            customSwitch(
              'Vegetarian',
              'Only vegetarian',
              filtersController.isActive(Filter.vegetarian),
              (val) => filtersController.setFilter(Filter.vegetarian, val),
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile customSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
