import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key key, @required this.pickedImageFileFunc})
      : super(key: key);

  final void Function(Uint8List imageFile) pickedImageFileFunc;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  Uint8List _image;
  final _picker = ImagePicker();

  Future<void> _pickedImage() async {
    try {
      final PickedFile pickedImage = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 150,
      );
      final Uint8List pickedImageAsBytes = await pickedImage.readAsBytes();

      setState(() {
        _image = pickedImageAsBytes;
      });
      widget.pickedImageFileFunc(pickedImageAsBytes);
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
          padding: const EdgeInsets.only(top: 30.0, bottom: 2.0),
          child: Hero(
            tag: 'logo',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 35.0,
              backgroundImage: _image != null
                  ? MemoryImage(_image)
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
