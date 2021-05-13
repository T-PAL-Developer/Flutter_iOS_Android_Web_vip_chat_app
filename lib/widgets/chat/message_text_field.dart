import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField(
      {Key key, this.messageTextController, this.onChanged, this.onSend})
      : super(key: key);

  final TextEditingController messageTextController;
  final Function(String) onChanged;
  final Function onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: messageTextController,
              decoration: kMessageTextFieldDecoration,
              style: TextStyle(
                color: Colors.white,
                fontFamily: kFontSourceSansPro,
                fontWeight: FontWeight.normal,
              ),
              onChanged: onChanged,
              onEditingComplete: onSend,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: IconButton(
              onPressed: onSend,
              iconSize: 18.0,
              color: kPrimaryColor,
              icon: Icon(FontAwesomeIcons.paperPlane),
            ),
          ),
        ],
      ),
    );
  }
}
