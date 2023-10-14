import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PossessionGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    String userID = FirebaseAuth.instance.currentUser.uid;
    final stream = fireStore
        .collection('possess')
        .where('owner', isEqualTo: userID)
        .snapshots();
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
                return GridView.count(
                  crossAxisCount: 1,
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onDoubleTap: () => print('show profile'),
                      child: CustomCard(
                        imageLink: document['picture'],
                        subTitle: 'Serial Number: ' + document['serialNumber'],
                        title: document['category'],
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            fireStore
                                .collection('possess')
                                .doc(document.id)
                                .delete();
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
