import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:provider/provider.dart';

class SearchLocationCardView extends StatelessWidget {
  static const String route = 'searchLocationScreen';
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarData>(
      builder: (context, value, child) {
        return Container(
          child: Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: value.getDataThroughLocation(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (!snapshot.hasData) {
                    return CustomText(
                      text: 'try with other location',
                    );
                  }
                  if (snapshot.data.docs.isEmpty) {
                    return CustomText(
                      text: 'try with other location',
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

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
                            Navigator.pushNamed(context, ChatPage.route);
                          },
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        );
      },
    );
  }
}
