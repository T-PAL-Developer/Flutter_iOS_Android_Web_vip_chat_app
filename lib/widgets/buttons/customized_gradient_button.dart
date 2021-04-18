import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/widgets/buttons/gradient_button.dart';

class CustomizedGradientButton extends StatelessWidget {
  CustomizedGradientButton({
    @required this.title,
    @required this.onTap,
    @required this.gradientColors,
    this.titleColor,
    this.width,
    this.height,
  });

  final String title;
  final Function onTap;
  final List<Color> gradientColors;
  final Color titleColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: GradientButton(
        title: title,
        onTap: onTap,
        width: (width != null) ? width : 200.0,
        height: (height != null) ? height : 50.0,
        duration: Duration(milliseconds: 60),
        borderRadius: BorderRadius.circular(100.0),
        wGradient: true,
        gradientColors: gradientColors,
        titleColor: (titleColor != null) ? titleColor : Colors.black,
        fontFamily: kFontSourceSansPro,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
