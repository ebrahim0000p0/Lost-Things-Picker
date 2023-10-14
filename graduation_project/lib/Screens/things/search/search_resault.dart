import 'package:flutter/material.dart';
import '../../../project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/Screens/things/search/search_location_screen.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';

class SearchResault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarData>(
      builder: (BuildContext context, value, Widget child) {
        return Container(
          child: Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: value.getDataThroughPossess(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return CustomText(text: 'Something went wrong');
                  }

                  if (!snapshot.hasData) {
                    return LocationButton();
                  }
                  if (snapshot.data.docs.isEmpty) {
                    return LocationButton();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomText(text: "Loading");
                  }
                  return GridView.count(
                    crossAxisCount: 1,
                    children: snapshot.data.docs.map((document) {
                      return CustomCard(
                        imageLink: document['picture'],
                        subTitle: document['serialNumber'],
                        title: document['category'],
                        trailing: IconButton(
                          icon: Icon(Icons.chat),
                          onPressed: () {
                            // print(document['owner']);
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

class LocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFlatButton(
      child: CustomText(text: 'Search With Location'),
      onPressed: () {
        Navigator.pushNamed(context, SearchLocationScreen.route);
        Provider.of<SearchBarData>(context, listen: false)
            .changeSearchBarValue('');
      },
      customIcon: CustomIcon(
        icon: Icons.location_on,
        size: 100,
      ),
    );
  }
}
