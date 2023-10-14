import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_body.dart';

class UploadPosses extends StatelessWidget {
  static const String route = '/Upload_poss';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Possession'),
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
      body: UploadPossesBody(),
    );
  }
}
