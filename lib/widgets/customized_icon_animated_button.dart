import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/widgets/animated_icon_button.dart';

class CustomizedIconAnimatedButton extends StatelessWidget {
  CustomizedIconAnimatedButton({
    @required this.title,
    @required this.onTap,
    @required this.gradientColors,
    @required this.icon,
    this.titleColor,
  });

  final String title;
  final Function onTap;
  final List<Color> gradientColors;
  final Color titleColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: AnimatedIconButton(
        icon: icon,
        width: 200.0,
        height: 50.0,
        duration: Duration(milliseconds: 60),
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.red,
        onTap: onTap,
        wGradient: true,
        gradientColors: gradientColors,
        title: title,
        titleColor: Colors.black,
        fontFamily: kFontSourceSansPro,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
