import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';

class GroupChatScreen extends StatefulWidget {
  static const String id = 'group_chat_screen';
  const GroupChatScreen({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChatScreen(
        auth: widget.auth, documentID: DocumentGroupChat.documentID, appBarTitle: 'Group Chat');
  }
}
