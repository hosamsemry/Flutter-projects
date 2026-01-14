import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final File image;

  Place({required this.title, required this.description, required this.image, required this.latitude, required this.longitude}) : id = uuid.v4();
}
