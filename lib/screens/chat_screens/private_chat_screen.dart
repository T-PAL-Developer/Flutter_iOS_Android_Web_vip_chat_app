import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_view.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class PrivateChatScreen extends StatefulWidget {
  static const String id = 'private_chat_screen';
  const PrivateChatScreen(
      {Key key, @required this.auth, @required this.chatRoomID, @required this.appBarName})
      : super(key: key);

  final AuthBase auth;
  final String chatRoomID;
  final String appBarName;

  @override
  _PrivateChatScreenState createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.appBarName,
          style: kAppBarTextStyle,
        ),
      ),
      body: SafeArea(
        child: ChatView(
          auth: widget.auth,
          documentID: widget.chatRoomID,
        ),
      ),
    );
  }
}
