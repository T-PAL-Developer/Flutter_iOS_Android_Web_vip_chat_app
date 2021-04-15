import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  PickedFile _image;
  final _picker = ImagePicker();

  Future<void> _pickedImage() async {
    try {
      final PickedFile pickedImage =
          await _picker.getImage(source: ImageSource.gallery);
      // final File pickedImageFile = File(pickedImage.path);
      setState(() {
        if (pickedImage != null) {
          _image = pickedImage;
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'logo',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40.0,
              backgroundImage: _image != null
                  ? ((!kIsWeb)
                      ? FileImage(File(_image.path))
                      : NetworkImage(_image.path))
                  : AssetImage('images/logo.png'),
            ),
          ),
        ),
        TextButton.icon(
          onPressed: _pickedImage,
          icon: Icon(Icons.image),
          label: Text(
            'Add Avatar  ',
            style: TextStyle(
              fontFamily: kFontSourceSansPro,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
