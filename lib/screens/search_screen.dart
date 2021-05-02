import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '️SEARCH',
          style: kAppBarTextStyle,
        ),
      ),
      body: Row(
        children: [
          Text('kkkk'),
        ],
      ),
    );
  }
}
