import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  final void Function(double latitude, double longitude) onSelectLocation;
  const LocationInput({super.key, required this.onSelectLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Future<void> _pickLocationOnMap() async {
    final pickedLocation = await showDialog<LatLng>(
      context: context,
      builder: (ctx) {
        LatLng? tempPicked;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Pick a location'),
              content: SizedBox(
                width: 300,
                height: 300,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(_latitude ?? 30.033333, _longitude ?? 31.233334),
                    initialZoom: 5,
                    onTap: (tapPos, latlng) {
                      setStateDialog(() {
                        tempPicked = latlng;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.places',
                    ),
                    MarkerLayer(
                      markers: tempPicked != null
                        ? [
                            Marker(
                              point: tempPicked!,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                            ),
                          ]
                        : [],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (tempPicked != null) {
                      Navigator.of(ctx).pop(tempPicked);
                    }
                  },
                  child: const Text('Select'),
                ),
              ],
            );
          },
        );
      },
    );
    if (pickedLocation != null) {
      setState(() {
        _latitude = pickedLocation.latitude;
        _longitude = pickedLocation.longitude;
      });
      widget.onSelectLocation(_latitude!, _longitude!);
    }
  }

  double? _latitude;
  double? _longitude;
  bool _isGettingLocation = false;

  Future<void> _getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    setState(() => _isGettingLocation = true);

    final locationData = await location.getLocation();

    setState(() {
      _isGettingLocation = false;
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
    });
    widget.onSelectLocation(_latitude!, _longitude!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'No location chosen',
      style: TextStyle(color: Colors.black),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_latitude != null && _longitude != null) {
      previewContent = FlutterMap(
        options: MapOptions(
          center: LatLng(_latitude!, _longitude!),
          zoom: 13,
          interactiveFlags: InteractiveFlag.none, // preview only
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.places',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(_latitude!, _longitude!),
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
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: previewContent,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.my_location),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Choose Location'),
              onPressed: _pickLocationOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
