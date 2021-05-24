import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_screen.dart';
import 'package:vip_chat_app/services/auth.dart';

class PrivateChatScreen extends StatefulWidget {
  static const String id = 'group_chat_screen';
  const PrivateChatScreen({Key key, @required this.auth, @required this.chatRoomID})
      : super(key: key);

  final AuthBase auth;
  final String chatRoomID;

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChatScreen(
        auth: widget.auth, documentID: widget.chatRoomID, appBarTitle: 'Private Chat');
  }
}
