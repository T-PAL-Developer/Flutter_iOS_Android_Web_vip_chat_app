import 'package:animated_drawer/views/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/screens/welcome_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'buttons/customized_text_button.dart';

class CustomizedAnimatedDrawer extends StatelessWidget {
  const CustomizedAnimatedDrawer(
      {Key key, @required this.homePageContent, @required this.authentication})
      : super(key: key);

  final homePageContent;
  final AuthBase authentication;

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
      homePageContent: homePageContent,
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
                    authentication.signOut();
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
