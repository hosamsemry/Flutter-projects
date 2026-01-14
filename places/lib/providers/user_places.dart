import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title, String description, File image, double latitude, double longitude) {
    final newPlace = Place(title: title, image: image, description: description, latitude: latitude, longitude: longitude);
    
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
      (ref) => UserPlacesNotifier(),
    );
