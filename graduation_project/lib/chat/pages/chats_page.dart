import 'package:graduation_project/chat/api/api.dart';
import 'package:graduation_project/chat/models/user.dart';
import 'package:graduation_project/chat/widget/chat_body_widget.dart';
import 'package:graduation_project/chat/widget/chat_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';

class ChatsPage extends StatelessWidget {
  static const String route = '/chats_page';
  @override
  Widget build(BuildContext context) => Scaffold(
        //   backgroundColor: KprimaryColor,
        body: SafeArea(
          child: StreamBuilder<List<UserModelChat>>(
            stream: FirebaseApi.getUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final users = snapshot.data;

                    if (users.isEmpty) {
                      return buildText('No Users Found');
                    } else
                      return Column(
                        children: [
                          ChatHeaderWidget(users: users),
                          ChatBodyWidget(users: users)
                        ],
                      );
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: KprimaryColor),
        ),
      );
}
