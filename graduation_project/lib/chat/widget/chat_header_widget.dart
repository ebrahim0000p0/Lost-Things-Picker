import 'package:graduation_project/chat/models/user.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<UserModelChat> users;

  const ChatHeaderWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'ChatsApp',
                style: TextStyle(
                  color: KprimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.search,
                        size: 40,
                        color: KprimaryColor,
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(uid: users[index]),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user.picture),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}
