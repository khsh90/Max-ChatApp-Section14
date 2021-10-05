import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _imageFile;
  void takeImage() async {
    final picker = ImagePicker();
    final pickImage = await picker.getImage(source: ImageSource.camera);

    final pickImageFile = File(pickImage.path);

    setState(() {
      _imageFile = pickImageFile;
      print(_imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: _imageFile != null ? FileImage(_imageFile) : null),
        FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: takeImage,
            icon: Icon(Icons.image),
            label: Text(
              'Take Image',
            ))
      ],
    );
  }
}
