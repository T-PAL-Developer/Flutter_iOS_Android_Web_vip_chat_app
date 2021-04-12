import 'package:flutter/material.dart';
import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vip_chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vip_chat_app/utilities/constantsFirebaseDB.dart';
import 'package:vip_chat_app/widgets/customized_text_button.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User _loggedInUser;
  DateTime _now;
  DateTime _date;
  String _messageText;

  void initState() {
    super.initState();
    _loggedInUser = widget.auth.currentUser;
  }

  Future<void> sendMessage() async {
    final userData = await FirebaseFirestore.instance
        .collection(CollectionUsers.id)
        .doc(_loggedInUser.uid)
        .get();
    _now = DateTime.now();
    _date = DateTime(_now.year, _now.month, _now.day, _now.hour, _now.minute);
    FirebaseFirestore.instance.collection(CollectionGroupChat.id).add({
      CollectionGroupChat.text: _messageText,
      CollectionGroupChat.sender:
          _loggedInUser.displayName ?? userData[CollectionUsers.username],
      CollectionGroupChat.time: _date.toString().substring(0, 16),
      CollectionGroupChat.uid: _loggedInUser.uid,
    });
    messageTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
      homePageXValue: 150,
      homePageYValue: 80,
      homePageAngle: -0.2,
      homePageSpeed: 250,
      shadowXValue: 122,
      shadowYValue: 110,
      shadowAngle: -0.275,
      shadowSpeed: 350,
      openIcon: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Icon(Icons.menu_open, color: Colors.black),
      ),
      closeIcon: Icon(Icons.arrow_back_ios, color: Colors.black),
      shadowColor: Colors.black54,
      backgroundGradient: LinearGradient(
        colors: [Colors.lightBlueAccent, Color(0xFF1f186f)],
      ),
      menuPageContent: _buildMenuPageContent(context),
      homePageContent: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: null,
          title: Text(
            '️Chat',
            style: TextStyle(
                fontFamily: kFontBungeeShade,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(
                loggedInUser: _loggedInUser,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: messageTextController,
                        decoration: kMessageTextFieldDecoration,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: kFontSourceSansPro,
                          fontWeight: FontWeight.normal,
                        ),
                        onChanged: (value) {
                          _messageText = value;
                        },
                        onEditingComplete: () {
                          sendMessage();
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        sendMessage();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuPageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0, left: 15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50.0,
                    child: Image.asset('images/logo.png'),
                  ),
                  Text(
                    "CHAT",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontFamily: kFontBungeeShade,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 40)),
            CustomizedTextButton(
              title: 'VIP Group Chat',
              onPressed: () {},
            ),
            CustomizedTextButton(
              title: 'Private Chat',
              onPressed: () {},
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Divider(
              color: Colors.black87,
              thickness: 2,
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            Row(
              children: [
                CustomizedTextButton(
                  title: 'Logout',
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                  },
                ),
                SizedBox(width: 6),
                FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.black87,
                  size: 14.0,
                ),
              ],
            ),
            CustomizedTextButton(
              title: 'About ',
              onPressed: () {},
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
  MessageContainer({this.text, this.sender, @required this.currentUser});

  final String text;
  final String sender;
  final bool currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            currentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              sender,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: kFontSourceSansPro,
                color: Colors.white54,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 30.0),
            decoration: BoxDecoration(
              color: currentUser ? Colors.lightBlueAccent : Colors.white,
              borderRadius: currentUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))
                  : BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                text ?? 'Text display error',
                style: TextStyle(
                    fontFamily: kFontSourceSansPro,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key, @required this.loggedInUser})
      : super(key: key);
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(CollectionGroupChat.id)
          .orderBy(CollectionGroupChat.time)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 150.0,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          List<MessageContainer> messagesWidgets = [];
          for (var message in messages) {
            final messageText = message.data()[CollectionGroupChat.text];
            final messageSender = message.data()[CollectionGroupChat.sender];
            final userMessage = message.data()[CollectionGroupChat.uid];
            final currentUser = loggedInUser.uid;

            final messageWidget = MessageContainer(
              text: messageText,
              sender: messageSender,
              currentUser: currentUser == userMessage,
            );
            messagesWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messagesWidgets,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error.toString()}');
        } else {
          return Text('unknown problem with database');
        }
      },
    );
  }
}
