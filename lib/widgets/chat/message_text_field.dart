import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({Key key, @required this.onSend}) : super(key: key);

  final Function onSend;

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _messageTextController = TextEditingController();
  String _messageText = '';

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
              controller: _messageTextController,
              decoration: kMessageTextFieldDecoration,
              style: TextStyle(
                color: Colors.white,
                fontFamily: kFontSourceSansPro,
                fontWeight: FontWeight.normal,
              ),
              onChanged: (value) {
                setState(() {
                  _messageText = value;
                });
              },
              onEditingComplete:
                  _messageText.trim().isEmpty ? null : widget.onSend,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: IconButton(
              onPressed: _messageText.trim().isEmpty ? null : widget.onSend,
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
