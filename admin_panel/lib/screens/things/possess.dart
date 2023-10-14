import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/custom_widgets/possess_grid_view.dart';
import 'package:flutter/material.dart';

class Possess extends StatelessWidget {
  static const String route = '/possess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomOutLineText(text: 'Possession'),
          SizedBox(
            height: 5,
          ),
          PossessGridView()
        ],
      ),
    );
  }
}
