import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/upload_body.dart';

class UploadLost extends StatefulWidget {
  static const String route = '/Upload_lost';
  @override
  State<StatefulWidget> createState() {
    return UploadLostState();
  }
}

class UploadLostState extends State<UploadLost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Lost'),
        iconTheme: IconThemeData(color: KprimaryColor, size: 20),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Home.route);
              },
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: UploadBody(),
    );
  }
}
