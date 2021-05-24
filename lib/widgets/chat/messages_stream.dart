import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';

import 'message_container.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key, @required this.loggedInUser, @required this.stream})
      : super(key: key);
  final User loggedInUser;
  final Stream<QuerySnapshot> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
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
          final chatDocs = snapshot.data.docs;
          final currentUser = loggedInUser.uid;

          return Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => MessageContainer(
                text: chatDocs[index][CollectionChatContent.text],
                sender: chatDocs[index][CollectionChatContent.sender],
                currentUser: currentUser == chatDocs[index][CollectionChatContent.uid],
                userImageURL: chatDocs[index][CollectionChatContent.imageUrl],
              ),
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
