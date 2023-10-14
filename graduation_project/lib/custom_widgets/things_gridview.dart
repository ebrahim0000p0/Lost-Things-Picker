import 'package:flutter/material.dart';
import 'package:graduation_project/chat/models/user.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ThingsGridView extends StatelessWidget {
  final String collectionName;
  ThingsGridView({@required this.collectionName});
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final stream = fireStore.collection(collectionName).snapshots();
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
                    return CustomCard(
                      imageLink: document['picture'],
                      subTitle: document['location'],
                      title: document['category'],
                      trailing: IconButton(
                        icon: Icon(Icons.chat),
                        onPressed: () {
                          print(document['ownerId']);
                          //TODO: shahat >> navigate to ur chat screen from here and <document['owner]> has owner id
                          // as string 'users/<uid>'
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                        uid: UserModelChat(
                                            idUser: document['ownerId'],
                                            name: document['ownerName'],
                                            picture: 'assets/image/berlin.jpg',
                                            lastMessageTime: DateTime.now()),
                                      )));
                        },
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
