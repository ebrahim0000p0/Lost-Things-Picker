import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/things/found_things/found_things.dart';
import 'package:graduation_project/Screens/things/lost_things/lost_things.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/drawer.dart';

class Home extends StatelessWidget {
  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(text: 'Home', context: context),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: CustomFlatButton(
                child: Text(
                  'Found Things',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'karla',
                    fontSize: 20,
                    color: KhintTextColor,
                  ),
                ),
                customIcon: CustomIcon(
                  icon: Icons.work,
                  size: 150,
                  color: KprimaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, FoundThings.route);
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: CustomFlatButton(
                child: Text(
                  'Lost Things',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'karla',
                    fontSize: 20,
                    color: KhintTextColor,
                  ),
                ),
                customIcon: CustomIcon(
                  icon: Icons.work_outline_outlined,
                  size: 150,
                  color: KprimaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LostThings.route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
