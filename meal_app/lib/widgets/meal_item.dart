import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;

  final void Function(Meal meal) onSelectMeal; 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap:()=> onSelectMeal(meal) ,
        child: Column(
          children: [
            Stack(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black45,
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(children: [
                    
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: Colors.black,),
                        SizedBox(width: 5,),
                        Text('${meal.duration.toString()} min', style: TextStyle(color: Colors.black),)
                      ], 
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Colors.black,),
                        SizedBox(width: 5,),
                        Text(meal.complexity.name, style: TextStyle(color: Colors.black),)
                      ], 
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.black,),
                        SizedBox(width: 5,),
                        Text(meal.affordability.name, style: TextStyle(color: Colors.black),)
                      ], 
                    ),                 
                  ],
                ),
              ),
            )
          ],
        ),
      
      ),
    );
  }
}
