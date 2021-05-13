import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/services/database.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/utilities/constantsFirebaseDB.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/search/users_container.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Database _database = Database();
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  QuerySnapshot _searchSnapshot;

  _findUser() async {
    FocusScope.of(context).unfocus();
    try {
      await _database.getUserByUsername(_searchTextEditingController.text).then(
        (value) {
          setState(
            () {
              _searchSnapshot = value;
              if (_searchSnapshot.docs.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'User does not exist. Check spelling (uppercase, lowercase or space)',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).errorColor,
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
  }

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
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Column(
              children: [
                _buildSearchWidget(),
                _buildSearchList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchTextEditingController,
            textInputAction: TextInputAction.search,
            onEditingComplete: _findUser,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: 'Search for username...',
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        IconButton(
          onPressed: _findUser,
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchList() {
    return _searchSnapshot != null
        ? Expanded(
            child: ListView.builder(
              itemCount: _searchSnapshot.docs.length,
              itemBuilder: (context, index) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                  child: UsersContainer(
                    userName: _searchSnapshot.docs[index]
                        .data()[CollectionUsers.username],
                    userImageUrl: _searchSnapshot.docs[index]
                        .data()[CollectionUsers.imageUrl],
                  ),
                );
              },
            ),
          )
        : Container();
  }
}
