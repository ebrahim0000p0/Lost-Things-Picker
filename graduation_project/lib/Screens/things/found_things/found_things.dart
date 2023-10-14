import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import '../../../project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/Screens/things/search/search_resault.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/drawer.dart';
import 'package:graduation_project/custom_widgets/things_gridview.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/Screens/things/found_things/Upload_Found.dart';

import '../../../project_models/provider_data/upload_provide_data.dart';

class FoundThings extends StatelessWidget {
  static const String route = '/found_things';

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchBarData>(context, listen: false)
        .changeCollectionValue('found_things');
    Provider.of<UploadData>(context, listen: false)
        .changeCollectionValue('found_things');

    return Consumer<SearchBarData>(
      builder: (context, searchBarData, child) {
        return Scaffold(
          floatingActionButton: CustomFloatActionButton(
            icon: Icons.add,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadFound()));
            },
          ),
          appBar: appbar(text: 'Found Things', context: context),
          drawer: CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  style: TextStyle(color: KhintTextColor),
                  keyboardType: TextInputType.text,
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter complete serial number'),
                  onChanged: (value) {
                    searchBarData.changeSearchBarValue(value);
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                searchBarData.searchBarValue.isEmpty
                    ? ThingsGridView(
                        collectionName: 'found_things',
                      )
                    : SearchResault(),
              ],
            ),
          ),
        );
      },
    );
  }
}
