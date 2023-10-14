import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final stream = fireStore.collection('chats').snapshots();
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              border: Border.all(color: KprimaryColor)),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(13),
                            dense: true,
                            title: Text(document['messages']),
                            subtitle: Container(),
                          )),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
