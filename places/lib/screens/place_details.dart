import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Image.file(
              place.image,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 12),

            // MAP
            Container(
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(place.latitude, place.longitude),
                    initialZoom: 13,
                    interactionOptions: InteractionOptions(
                      enableScrollWheel: true,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.places',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point:
                              LatLng(place.latitude, place.longitude),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Name: ${place.title.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // DESCRIPTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Description: ${place.description}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 68, 68, 68),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
