import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_view.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/services/push_notifications.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';
import 'package:vip_chat_app/widgets/customized_animated_drawer.dart';

class GroupChatScreen extends StatefulWidget {
  static const String id = 'group_chat_screen';
  const GroupChatScreen({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  FirebaseCloudMessaging _firebaseCloudMessaging = FirebaseCloudMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseCloudMessaging.fcmRequestPermission();
    _firebaseCloudMessaging.fcmForegroundNotification();
    _firebaseCloudMessaging.fcmSubscribeToTopic();
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
            '️Group Chat',
            style: kAppBarTextStyle,
          ),
        ),
        body: SafeArea(
          child: ChatView(
            auth: widget.auth,
            documentID: DocumentGroupChat.documentID,
          ),
        ),
      ),
    );
  }
}
