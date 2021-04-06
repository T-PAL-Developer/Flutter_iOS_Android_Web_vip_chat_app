import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/widgets/animated_button.dart';

class CustomizedBigAnimatedButton extends StatelessWidget {
  CustomizedBigAnimatedButton(
      {@required this.title,
      @required this.onTap,
      @required this.gradientColors,
      this.titleColor});

  final String title;
  final Function onTap;
  final List<Color> gradientColors;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: AnimatedButton(
        title: title,
        onTap: onTap,
        duration: Duration(milliseconds: 60),
        borderRadius: BorderRadius.circular(100),
        wGradient: true,
        gradientColors: gradientColors,
        titleColor: (titleColor != null) ? titleColor : Colors.black,
        fontFamily: kFontSourceSansPro,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
