import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/search_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/widgets/customized_animated_drawer.dart';

class ChatRoomScreen extends StatefulWidget {
  static const String id = 'chat_room_screen';
  const ChatRoomScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
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
          child: Container(
            color: kBackgroundColor,
          ),
        ),
      ),
    );
  }
}
