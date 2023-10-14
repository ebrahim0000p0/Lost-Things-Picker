import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/Screens/home.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/profile/custum_profile_widgets/profile_poss_gridview.dart';
import 'package:graduation_project/profile/pages/upload_poss_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

final possesRef = FirebaseFirestore.instance.collection('possess');
final storageRef = FirebaseStorage.instance.ref();

class Possess extends StatelessWidget {
  static const String route = 'possess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatActionButton(
          icon: Icons.add,
          onPressed: () => Navigator.pushNamed(context, UploadPosses.route)),
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Possession'),
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
      body: Column(
        children: [
          PossessionGridView(),
        ],
      ),
    );
  }
}
