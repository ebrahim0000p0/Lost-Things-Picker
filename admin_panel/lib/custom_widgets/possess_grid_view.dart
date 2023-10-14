import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PossessGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final stream = fireStore.collection('possess').snapshots();
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
                  //        crossAxisCount: 1,
                  children: snapshot.data.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            border: Border.all(color: KprimaryColor)
                            // color: KprimaryColor,
                            ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(13),
                          dense: true,
                          title: Text('ID: ' + document['possessId']),
                          subtitle: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      document['picture'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text('Owner Name: ' + document['ownerName']),
                              Text('Category: ' + document['category']),
                              Text(
                                  'Serial Number: ' + document['serialNumber']),
                              //   Text('description: ' + document['description']),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 50,
                            ),
                            onPressed: () {
                              print(document.id);
                              fireStore
                                  .collection('possess')
                                  .doc(document.id)
                                  .delete()
                                  .then((value) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      content: Text(
                                        'Deleted Done',
                                        textAlign: TextAlign.center,
                                        style: KTextStyle,
                                      ),
                                      actions: [
                                        CustomFlatButton(
                                          child: Text(
                                            'Ok',
                                            style: KTextStyle,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }).catchError((error) {
                                return AlertDialog(
                                  content: CustomOutLineText(
                                    text: 'Error',
                                  ),
                                  actions: [
                                    CustomFlatButton(
                                      child: Text(
                                        'Ok',
                                        style: KTextStyle,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              ;
            }),
      ),
    );
  }
}
