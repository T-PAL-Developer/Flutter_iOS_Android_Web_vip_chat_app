import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/private_chat_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/services/database.dart';
import 'package:vip_chat_app/utilities/constants.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';
import 'package:vip_chat_app/utilities/firebase_error_codes.dart';
import 'package:vip_chat_app/widgets/search/users_container.dart';

import 'chat_room_screen.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  const SearchScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Database _database = Database();
  final TextEditingController _searchTextEditingController = TextEditingController();
  QuerySnapshot _searchSnapshot;
  User _loggedInUser;

  Future<void> _findUser() async {
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

  _createChatRoom({String searchedUserUid, String searchedUserUrl, String searchedUserName}) async {
    List<String> usersUid = [_loggedInUser.uid, searchedUserUid];
    String chatRoomId = _createChatRoomId(_loggedInUser.uid, searchedUserUid);

    Map<String, dynamic> chatRoomUsersInfoMap = {
      CollectionChatsRooms.chatRoomId: chatRoomId,
      CollectionChatsRooms.usersUid: usersUid,
    };
    try {
      await _database.createChatRoom(chatRoomUsersInfoMap, chatRoomId).then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PrivateChatScreen(auth: widget.auth, chatRoomID: chatRoomId)),
            ),
          );
    } on FirebaseAuthException catch (e) {
      helperFirebaseAuthException(e, context);
    }
  }

  _createChatRoomId(String a, String b) {
    if (a.substring(0, 4).codeUnitAt(0) > b.substring(0, 4).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  void initState() {
    super.initState();
    _loggedInUser = widget.auth.currentUser;
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
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
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
                final snapshot = _searchSnapshot.docs[index].data();
                return ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
                  child: UsersContainer(
                    userName: snapshot[CollectionUsers.username],
                    userImageUrl: snapshot[CollectionUsers.imageUrl],
                    onPressed: (snapshot[CollectionUsers.uid] == _loggedInUser.uid)
                        ? null
                        : () {
                            _createChatRoom(
                              searchedUserName: snapshot[CollectionUsers.username],
                              searchedUserUid: snapshot[CollectionUsers.uid],
                              searchedUserUrl: snapshot[CollectionUsers.imageUrl],
                            );
                          },
                  ),
                );
              },
            ),
          )
        : Container();
  }
}
