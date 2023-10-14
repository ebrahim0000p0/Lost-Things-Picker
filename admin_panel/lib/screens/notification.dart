import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final stream = fireStore.collection('admin_notification').snapshots();

    return Container(
      child: Flexible(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return CustomText(text: 'Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomText(text: "Loading");
            }
            if (true) {
              //----------------------------------
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return ListTile(
                    tileColor: Colors.orange.withOpacity(.2),
                    title: Text(
                      document['ok'],
                      style: TextStyle(fontSize: 20, color: KsecondryColor),
                    ),
                    leading: CircleAvatar(
                      radius: 50,
                      child: CustomIcon(
                        icon: Icons.map,
                        size: 50,
                        color: KsecondryColor,
                      ),
                    ),
                    subtitle: Text('data'),
                    onTap: () {},
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
