import 'package:flutter/material.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class UsersContainer extends StatelessWidget {
  const UsersContainer(
      {Key key, @required this.userName, @required this.userImageUrl, this.onPressed})
      : super(key: key);
  final String userName;
  final String userImageUrl;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, right: 42),
      constraints: BoxConstraints(maxWidth: 200.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(userImageUrl),
          ),
          SizedBox(
            width: 10,
          ),
          Text(userName.toUpperCase(), style: kWhiteTextStyle),
          Spacer(),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.person_add_rounded),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
