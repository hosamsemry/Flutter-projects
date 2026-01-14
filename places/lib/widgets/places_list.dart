import 'package:flutter/material.dart';
import 'package:places/models/place.dart';
import 'package:places/screens/place_details.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty){
      return Center(
        child: Text(
          'No places added yet!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
            child: ListTile(
              focusColor: Colors.transparent,
              autofocus: true,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailsScreen(place: place,),
                    ),
                  );
              },
              title: Text(
                place.title,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: FileImage(place.image),
              ),
            ),
          ),
        );
      },
    );
  }
}
