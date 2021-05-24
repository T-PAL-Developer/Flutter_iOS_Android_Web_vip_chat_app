import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vip_chat_app/utilities/constants.dart';

class ChatsListContainer extends StatelessWidget {
  const ChatsListContainer({
    Key key,
    @required this.userName,
    @required this.userImageUrl,
    this.onPressed,
    @required this.loggedInUserUid,
    @required this.secondUserName,
    @required this.secondUserImageUrl,
    this.firstUserUid,
    this.secondUserUid,
  }) : super(key: key);
  final String userName;
  final String userImageUrl;
  final String secondUserName;
  final String secondUserImageUrl;
  final Function onPressed;
  final String loggedInUserUid;
  final String firstUserUid;
  final String secondUserUid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(30.0))),
          constraints: BoxConstraints(maxWidth: 200.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (loggedInUserUid != firstUserUid)
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(userImageUrl),
                  ),
                if (loggedInUserUid != secondUserUid)
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(secondUserImageUrl),
                  ),
                SizedBox(
                  width: 10,
                ),
                if (loggedInUserUid != firstUserUid)
                  Text(userName.toUpperCase(), style: kWhiteTextStyle),
                if (loggedInUserUid != secondUserUid)
                  Text(secondUserName.toUpperCase(), style: kWhiteTextStyle),
                Spacer(),
                IconButton(
                  color: kPrimaryColor,
                  icon: Icon(FontAwesomeIcons.paperPlane),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
