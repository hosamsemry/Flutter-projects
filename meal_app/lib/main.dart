import 'package:flutter/material.dart';
import 'package:meal_app/controllers/filters_controller.dart';
import 'package:meal_app/screens/bottom_nav.dart';
import 'package:get/get.dart';
import 'controllers/meals_controller.dart';

void main() {

  Get.put(MealsController());
  Get.put(FiltersController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark,),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, // title & icons color
          centerTitle: true,
        ),
      ),
      home: BottomNav(),
    );
  }
}
