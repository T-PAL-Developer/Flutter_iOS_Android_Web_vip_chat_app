import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomizedTextButton extends StatelessWidget {
  CustomizedTextButton(
      {@required this.title,
      @required this.onPressed,
      this.fontFamily,
      this.fontWeight,
      this.color,
      this.fontSize});

  final String title;
  final Function onPressed;
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth: 15.0, minHeight: 36.0),
      textStyle: TextStyle(
        color: (color != null) ? color : Colors.black87,
        fontFamily: fontFamily,
        fontWeight: (fontWeight != null) ? fontWeight : FontWeight.bold,
        fontSize: (fontSize != null) ? fontSize : 15,
      ),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
