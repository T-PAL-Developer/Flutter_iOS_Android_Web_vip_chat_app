import 'package:flutter/material.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/services/database.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/chat/message_text_field.dart';
import 'package:vip_chat_app/widgets/chat/messages_stream.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key key, @required this.auth, @required this.documentID}) : super(key: key);
  final AuthBase auth;
  final String documentID;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageTextController = TextEditingController();
  final Database _database = Database();
  String _messageText = '';
  User _loggedInUser;

  void initState() {
    super.initState();
    _loggedInUser = widget.auth.currentUser;
  }

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    try {
      await _database.uploadMessage(
          user: _loggedInUser, chatRoomId: widget.documentID, messageText: _messageText);
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
    setState(() {
      _messageTextController.clear();
      _messageText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MessagesStream(
            stream: _database.getChatContent(widget.documentID),
            loggedInUser: _loggedInUser,
          ),
          MessageTextField(
            onButtonPressed: _messageText.trim().isEmpty ? null : _sendMessage,
            messageTextController: _messageTextController,
            onChanged: (value) {
              setState(
                () {
                  _messageText = value;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
