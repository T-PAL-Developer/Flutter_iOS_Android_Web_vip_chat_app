import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class MessageContainer extends StatelessWidget {
  MessageContainer({
    this.text,
    this.sender,
    @required this.currentUser,
    this.userImageURL,
    @required this.date,
  });

  final String text;
  final String sender;
  final bool currentUser;
  final String userImageURL;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: currentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Expanded(
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
                                topRight: Radius.circular(30.0))
                            : BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 15.0),
                        child: Column(
                          crossAxisAlignment:
                              currentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              text ?? 'Text display error',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: kFontSourceSansPro,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.0),
                                Text(
                                  DateFormat.d().add_MMMM().add_Hm().format(date.toDate()) ??
                                      'Text display error',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: kFontSourceSansPro,
                                      fontWeight: FontWeight.w500,
                                      color: kBackgroundColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 28,
          left: currentUser ? null : 5,
          right: currentUser ? 5 : null,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(userImageURL),
          ),
        ),
      ],
    );
  }
}
