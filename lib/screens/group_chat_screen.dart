import 'package:flutter/material.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/services/database.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/chat/message_text_field.dart';
import 'package:vip_chat_app/widgets/chat/messages_stream.dart';
import 'package:vip_chat_app/widgets/customized_animated_drawer.dart';

class GroupChatScreen extends StatefulWidget {
  static const String id = 'group_chat_screen';
  const GroupChatScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
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
      await _database.uploadMessage(_loggedInUser, _messageText);
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
    return CustomizedAnimatedDrawer(
      authentication: widget.auth,
      homePageContent: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            leading: null,
            title: Text(
              '️GROUP CHAT',
              style: kAppBarTextStyle,
            ),
          ),
          body: SafeArea(
            child: Container(
              color: kBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MessagesStream(
                    stream: _database.getChatContent(CollectionGroupChat.id),
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
            ),
          ),
        ),
      ),
    );
  }
}
