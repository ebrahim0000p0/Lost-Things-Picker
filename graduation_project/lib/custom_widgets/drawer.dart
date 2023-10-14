import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import 'package:graduation_project/Screens/things/found_things/found_things.dart';
import 'package:graduation_project/Screens/things/lost_things/lost_things.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/profile/pages/profile.dart';
import '../project_models/provider_data/user_data.dart';
import 'package:provider/provider.dart';
import '../project_models/user_model.dart';

UserModel currentUser;

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: Provider.of<UserProvider>(context).stream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return CircularProgressIndicator();
                  }
                  final userData = snapshot.data;

                  ImageProvider userimage =
                      userData['picture'].toString().isEmpty
                          ? AssetImage('assets/images/pavatar.png')
                          : NetworkImage(
                              userData['picture'],
                            );
                  return DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: userimage,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Profile.route);
                          },
                          child: Text(
                            userData['name'],
                            style: TextStyle(
                                fontSize: 20,
                                color: KsecondryColor,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'karla'),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Expanded(
                child: Column(
              children: [
                CustomListTile(
                  icon: Icons.person_outlined,
                  text: 'Profile',
                  routeName: Profile.route,
                ),
                CustomDivider(),
                /////////////////////////
                customSizedBox(),
                CustomListTile(
                  icon: Icons.home,
                  text: 'home',
                  routeName: Home.route,
                ),
                CustomDivider(),
                //////////////////////////////////
                customSizedBox(),
                CustomListTile(
                  icon: Icons.work_outline_outlined,
                  text: 'Lost Things',
                  routeName: LostThings.route,
                ),
                CustomDivider(),
                //////////////////////////
                customSizedBox(),
                CustomListTile(
                  icon: Icons.work,
                  text: 'Found Things',
                  routeName: FoundThings.route,
                ),
                CustomDivider(),
                //////////////////////////////////
                customSizedBox(),
                CustomListTile(
                  icon: Icons.settings,
                  text: 'Settings',
                  routeName: 'edit',
                ),
                CustomDivider(),
              ],
            )),
            Column(
              children: [
                //  CustomDivider(),
                CustomListTile(
                  icon: Icons.logout,
                  text: 'Log Out',
                  routeName: 'logout',
                  iconColor: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      //  color: KsecondryColor,
      thickness: 1,
      endIndent: 55,
    );
  }
}

Widget customSizedBox() {
  return SizedBox(
    height: 0,
  );
}
