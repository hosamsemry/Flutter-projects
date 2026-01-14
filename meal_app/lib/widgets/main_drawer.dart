import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_app/controllers/filters_controller.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key, required this.onSelectedScreen});

  final void Function(String identifier) onSelectedScreen;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool _filtersExpanded = false;
  final FiltersController filtersController = Get.find<FiltersController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 197, 34, 22),
                  Color.fromARGB(255, 15, 96, 162),
                ],
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.fastfood, size: 48, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Your fav Restaurant',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: const Text('Meals'),
            onTap: () => widget.onSelectedScreen('meals'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Filters'),
            trailing: Icon(_filtersExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _filtersExpanded = !_filtersExpanded;
              });
            },
          ),
          if (_filtersExpanded)
            Obx(() => Column(
                  children: [
                    _customSwitch(
                      'Gluten-free',
                      'No gluten',
                      filtersController.isActive(Filter.glutenFree),
                      (val) => filtersController.setFilter(Filter.glutenFree, val),
                    ),
                    _customSwitch(
                      'Lactose-free',
                      'No lactose',
                      filtersController.isActive(Filter.lactoseFree),
                      (val) => filtersController.setFilter(Filter.lactoseFree, val),
                    ),
                    _customSwitch(
                      'Vegan',
                      'Only vegan',
                      filtersController.isActive(Filter.vegan),
                      (val) => filtersController.setFilter(Filter.vegan, val),
                    ),
                    _customSwitch(
                      'Vegetarian',
                      'Only vegetarian',
                      filtersController.isActive(Filter.vegetarian),
                      (val) => filtersController.setFilter(Filter.vegetarian, val),
                    ),
                  ],
                )),
        ],
      ),
    );
  }

  Widget _customSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

