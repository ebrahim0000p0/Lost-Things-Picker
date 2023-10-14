import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/custom_widgets/things_gridview.dart';
import 'package:flutter/material.dart';

class FoundThings extends StatelessWidget {
  static const String route = '/found_things';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomOutLineText(text: 'Found Things'),
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
