import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class CustomizedTextFormField extends StatelessWidget {
  CustomizedTextFormField({
    @required this.hintText,
    this.onChanged,
    this.icon,
    this.obscureText,
    this.keyboardType,
    this.validator,
    this.controller,
    this.onSaved,
    this.key,
  });

  final String hintText;
  final void Function(String) onChanged;
  final Widget icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) validator;
  final TextEditingController controller;
  final Function(String) onSaved;
  final ValueKey key;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: 400.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: TextFormField(
          key: key ?? null,
          onSaved: onSaved ?? null,
          controller: controller ?? null,
          validator: validator ?? null,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText ?? false,
          onChanged: onChanged ?? null,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily: kFontSourceSansPro,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            prefixIcon: icon ?? null,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: kFontSourceSansPro,
              fontWeight: FontWeight.normal,
              color: Colors.black45,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        ),
      ),
    );
  }
}
