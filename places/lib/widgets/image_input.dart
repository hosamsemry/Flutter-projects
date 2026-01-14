import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onImagePicked});

  final void Function(File image) onImagePicked;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();


  File? _pickedImage;
  void _uploadImage() {
    _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
    ).then((value) {
      if (value != null) {
        setState(() {
          _pickedImage = File(value.path);
        });
        widget.onImagePicked(_pickedImage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: _pickedImage == null ? TextButton.icon(
        onPressed: _uploadImage,
        icon: Icon(Icons.camera),
        label: Text(
          'Upload a picture',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(foregroundColor: Colors.black),
      ) : GestureDetector(onTap: _uploadImage, child: Image.file(_pickedImage!, width: double.infinity, height: double.infinity, fit: BoxFit.cover,)),
    );
  }
}
