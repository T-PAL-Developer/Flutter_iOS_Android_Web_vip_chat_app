import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedButton extends StatefulWidget {
  final Function onTap;
  final String title;
  final Duration duration;
  //final Curve curve;
  final BorderRadius borderRadius;
  final List<Shadow> boxShadow;
  final Color color;
  final bool wGradient;
  final List<Color> gradientColors;
  final Alignment beginGradient;
  final Alignment endGradient;
  final Color titleColor;
  final double titleSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final double height;
  final double width;

  AnimatedButton({
    @required this.onTap,
    @required this.title,
    this.duration,
    //this.curve,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.wGradient,
    this.gradientColors,
    this.beginGradient,
    this.endGradient,
    this.titleColor,
    this.titleSize,
    this.fontWeight,
    this.fontFamily,
    this.height,
    this.width,
  });
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _animationController;
  //Animation curve;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: (widget.duration != null)
          ? widget.duration
          : Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 0.1,
    );

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;
    return MouseRegion(
      onHover: (config) {
        _animationController.forward();
      },
      onExit: (config) {
        _animationController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) {
          _animationController.forward();
        },
        onTapCancel: () {
          _animationController.reverse();
        },
        onTapUp: (details) {
          _animationController.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: buttonBody(),
        ),
      ),
    );
  }

  Widget buttonBody() {
    return Container(
      height: (widget.height != null) ? widget.height : 70,
      width: (widget.width != null) ? widget.width : 200,
      decoration: boxDecoration(),
      child: Center(
        child: Text(
          (widget.title != null) ? widget.title : "animated button",
          style: TextStyle(
            fontFamily: widget.fontFamily,
            fontSize: (widget.titleSize != null) ? widget.titleSize : 20,
            fontWeight: (widget.fontWeight != null)
                ? widget.fontWeight
                : FontWeight.w500,
            color:
                (widget.titleColor != null) ? widget.titleColor : Colors.black,
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: (widget.color != null) ? widget.color : Colors.white,
      borderRadius: (widget.borderRadius != null)
          ? widget.borderRadius
          : BorderRadius.circular(10),
      boxShadow: (widget.boxShadow != null)
          ? widget.boxShadow
          : [
              BoxShadow(
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],

      ///
      gradient: (widget.wGradient == true)
          ? (widget.gradientColors != null)
              ? LinearGradient(
                  colors: widget.gradientColors,
                  begin: (widget.beginGradient != null)
                      ? widget.beginGradient
                      : Alignment.topRight,
                  end: (widget.endGradient != null)
                      ? widget.beginGradient
                      : Alignment.bottomLeft,
                )
              : LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Color(0xff4267B2).withOpacity(.7),
                  ],
                )
          : null,

      ///
    );
  }
}
