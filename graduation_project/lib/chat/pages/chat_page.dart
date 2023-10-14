import 'package:graduation_project/chat/models/user.dart';
import 'package:graduation_project/chat/widget/messages_widget.dart';
import 'package:graduation_project/chat/widget/new_message_widget.dart';
import 'package:graduation_project/chat/widget/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String route = '/chat_page';
  final UserModelChat uid;

  const ChatPage({
    @required this.uid,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.uid.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(idUser: widget.uid.idUser),
                ),
              ),
              NewMessageWidget(idUser: widget.uid.idUser)
            ],
          ),
        ),
      );
}
