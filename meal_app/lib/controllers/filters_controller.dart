import 'package:get/get.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersController extends GetxController {
  final filters = <Filter, bool>{
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  }.obs;

  void setFilter(Filter filter, bool value) {
    filters[filter] = value;
  }

  bool isActive(Filter filter) {
    return filters[filter] ?? false;
  }
}
