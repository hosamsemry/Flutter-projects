import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/providers/user_places.dart';
import 'package:places/widgets/image_input.dart';
import 'package:places/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _pickedImage;
  double? _latitude;
  double? _longitude;

  void _savePlace(){
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    if (enteredTitle.trim().isEmpty || _pickedImage == null || _latitude == null || _longitude == null){
      return;
    } 
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, enteredDescription, _pickedImage!, _latitude!, _longitude!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('Title'),
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(
                label: Text('Description'),
              ),
              controller: _descriptionController,
            ),
            
            SizedBox(height: 16),
            ImageInput(onImagePicked: (File image)=>_pickedImage = image),
            SizedBox(height: 16),
            LocationInput(
              onSelectLocation: (lat, lng) {
                _latitude = lat;
                _longitude = lng;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: _savePlace,
              label: Text('Add Place', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}