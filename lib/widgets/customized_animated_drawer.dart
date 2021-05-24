import 'package:animated_drawer/bloc/home_page_bloc.dart';
import 'package:animated_drawer/bloc/shadow_bloc.dart';
import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/screens/chat_screens/chat_room_screens/chat_room_screen.dart';
import 'package:vip_chat_app/screens/chat_screens/group_chat_screen.dart';
import 'package:vip_chat_app/screens/welcome_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class CustomizedAnimatedDrawer extends StatefulWidget {
  const CustomizedAnimatedDrawer(
      {Key key, @required this.homePageContent, @required this.authentication})
      : super(key: key);

  final Widget homePageContent;
  final AuthBase authentication;

  @override
  _CustomizedAnimatedDrawerState createState() =>
      _CustomizedAnimatedDrawerState();
}

class _CustomizedAnimatedDrawerState extends State<CustomizedAnimatedDrawer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
      homePageXValue: 170,
      homePageYValue: 80,
      homePageAngle: -0.1,
      homePageSpeed: 250,
      shadowXValue: 140,
      shadowYValue: 50,
      shadowAngle: -0.125,
      shadowSpeed: 300,
      openIcon: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Icon(Icons.menu_open, color: Colors.black),
      ),
      closeIcon: Icon(Icons.arrow_back_ios, color: Colors.black),
      shadowColor: Colors.black54,
      backgroundGradient: LinearGradient(
        colors: [
          kPrimaryColor,
          Color(0xff3f3fba),
          kBackgroundColor,
        ],
      ),
      menuPageContent: _buildMenuPageContent(context),
      homePageContent: GestureDetector(
        onTap: () {
          if (HomePageBloc.isOpen)
            setState(() {
              HomePageBloc().closeDrawer();
              ShadowBLOC().closeDrawer();
            });
        },
        child: widget.homePageContent,
      ),
    );
  }

  Widget _buildMenuPageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0, left: 15),
      child: Container(
        child: SingleChildScrollView(
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
              Padding(padding: EdgeInsets.only(bottom: 50)),
              _buildGroupChatBtn(context),
              Padding(padding: EdgeInsets.only(bottom: 40)),
              _buildPrivateChatsBtn(context),
              Padding(padding: EdgeInsets.only(bottom: 50)),
              Divider(
                color: Colors.black87,
                thickness: 2,
              ),
              Padding(padding: EdgeInsets.only(bottom: 50)),
              _buildLogoutBtn(context),
              Padding(padding: EdgeInsets.only(bottom: 40)),
              _buildAboutBtn(),
              Padding(padding: EdgeInsets.only(bottom: 50)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupChatBtn(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          HomePageBloc().closeDrawer();
          Navigator.pushNamedAndRemoveUntil(
              context, GroupChatScreen.id, (route) => false);
        },
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.users,
              color: Colors.black87,
              size: 14.0,
            ),
            SizedBox(width: 6),
            Text(
              'Group Chat',
              style: kAnimatedDrawerMenuTextStyle,
            ),
            SizedBox(width: 6),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivateChatsBtn(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          HomePageBloc().closeDrawer();
          Navigator.pushNamedAndRemoveUntil(
              context, ChatRoomScreen.id, (route) => false);
        },
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidComments,
              color: Colors.black87,
              size: 14.0,
            ),
            SizedBox(width: 6),
            Text(
              'Private Chats',
              style: kAnimatedDrawerMenuTextStyle,
            ),
            SizedBox(width: 6),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.authentication.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, WelcomeScreen.id, (route) => false);
        },
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black87,
              size: 14.0,
            ),
            SizedBox(width: 6),
            Text(
              'Logout',
              style: kAnimatedDrawerMenuTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutBtn() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.infoCircle,
              color: Colors.black87,
              size: 14.0,
            ),
            SizedBox(width: 6),
            Text(
              'About',
              style: kAnimatedDrawerMenuTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
