import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_room_screens/search_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/services/database.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/widgets/customized_animated_drawer.dart';
import 'package:vip_chat_app/widgets/search/chats_list_stream.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String id = 'chat_room_screen';
  const ChatRoomScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final Database _database = Database();
  User _loggedInUser;

  void initState() {
    super.initState();
    _loggedInUser = widget.auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return CustomizedAnimatedDrawer(
      authentication: widget.auth,
      homePageContent: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: null,
          title: Text(
            '️CHATS ROOM',
            style: kAppBarTextStyle,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, SearchScreen.id);
          },
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              color: kBackgroundColor,
              child: Column(
                children: [
                  ChatsListStream(
                    stream: _database.getPrivateChats(_loggedInUser.uid),
                    loggedInUser: _loggedInUser,
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
