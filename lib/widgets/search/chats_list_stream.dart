import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vip_chat_app/screens/chat_screens/private_chat_screen.dart';
import 'package:vip_chat_app/services/auth.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';
import 'package:vip_chat_app/widgets/search/chats_list_container.dart';

class ChatsListStream extends StatelessWidget {
  const ChatsListStream({Key key, @required this.loggedInUser, @required this.stream, this.auth})
      : super(key: key);
  final User loggedInUser;
  final Stream<QuerySnapshot> stream;
  final AuthBase auth;

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
          final chatsListSnapshot = snapshot.data.docs;
          List<ChatsListContainer> chatsListContainerWidgets = [];

          for (int i = 0; i < chatsListSnapshot.length; i++) {
            final List userUidList = chatsListSnapshot[i][CollectionChatsRooms.usersUid];
            final List userNameList = chatsListSnapshot[i][CollectionChatsRooms.username];
            final List userImageUrlList = chatsListSnapshot[i][CollectionChatsRooms.imageUrl];
            final String usersChatsList = chatsListSnapshot[i][CollectionChatsRooms.chatRoomId];
            for (int i = 0; i < userUidList.length; i++) {
              final userUid = userUidList[i];
              if (userUid == loggedInUser.uid) {
                continue;
              }
              final userName = userNameList[i];
              final userImageUrl = userImageUrlList[i];
              final chatsListContainer = ChatsListContainer(
                userName: userName,
                userImageUrl: userImageUrl,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivateChatScreen(
                        auth: Auth(),
                        appBarName: userName,
                        chatRoomID: usersChatsList,
                      ),
                    ),
                  );
                },
              );

              chatsListContainerWidgets.add(chatsListContainer);
            }
          }
          return Expanded(
            child: ListView(
              children: chatsListContainerWidgets,
            ),
            // child: ListView.builder(
            //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            //   itemCount: chatsList.length,
            //   itemBuilder: (context, index) => ChatsListContainer(
            //     loggedInUserUid: loggedInUser.uid,
            //     firstUserUid: chatsList[index][CollectionChatsRooms.usersUid][0],
            //     secondUserUid: chatsList[index][CollectionChatsRooms.usersUid][1],
            //     userName: chatsList[index][CollectionChatsRooms.username][0],
            //     userImageUrl: chatsList[index][CollectionChatsRooms.imageUrl][0],
            //     secondUserName: chatsList[index][CollectionChatsRooms.username][1],
            //     secondUserImageUrl: chatsList[index][CollectionChatsRooms.imageUrl][1],
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => PrivateChatScreen(
            //                 auth: Auth(),
            //                 chatRoomID: chatsList[index][CollectionChatsRooms.chatRoomId])),
            //       );
            //     },
            //   ),
            // ),
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
