import 'package:graduation_project/chat/models/user.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<UserModelChat> users;

  const ChatBodyWidget({
    @required this.users,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                border: Border.all(color: KprimaryColor)
                // color: KprimaryColor,
                ),
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(uid: user),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(user.picture),
              ),
              title: Container(
                child: Text(
                  user.name,
                  style: TextStyle(
                      color: KprimaryColor,
                      fontFamily: 'karla',
                      fontWeight: FontWeight.w100,
                      fontSize: 22),
                ),
              ),
            ),
          );
        },
        itemCount: users.length,
      );
}
