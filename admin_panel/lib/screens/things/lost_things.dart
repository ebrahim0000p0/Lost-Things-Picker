import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/custom_widgets/things_gridview.dart';
import 'package:flutter/material.dart';

class LostThings extends StatelessWidget {
  static const String route = '/lost_things';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomOutLineText(text: 'Lost Things'),
          SizedBox(
            height: 5,
          ),
          ThingsGridView(
            collectionName: 'lost_things',
          )
        ],
      ),
    );
  }
}
