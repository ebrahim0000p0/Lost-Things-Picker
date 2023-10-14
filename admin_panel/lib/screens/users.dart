import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/custom_widgets/users_gridview.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  static const String route = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomOutLineText(text: 'Users'),
          SizedBox(
            height: 5,
          ),
          UsersGridView(),
        ],
      ),
    );
  }
}
