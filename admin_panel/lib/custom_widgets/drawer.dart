// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           StreamBuilder<DocumentSnapshot>(
//               stream: Provider.of<UserProvider>(context).stream(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData == false) {
//                   return CircularProgressIndicator();
//                 }
//                 final userData = snapshot.data;

//                 return DrawerHeader(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(
//                           userData['picture'],
//                         ),
//                       ),
//                       Expanded(
//                         child: FlatButton(
//                           onPressed: () {
//                             //go to profile
//                           },
//                           child: Text(
//                             userData['name'],
//                             style: TextStyle(
//                                 fontSize: 21,
//                                 color: KsecondryColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'karla'),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               }),
//           Expanded(
//               child: Column(
//             children: [
//               CustomListTile(
//                 icon: Icons.person_outlined,
//                 text: 'Profile',
//                 //TODO: el deep write route of profile page as <Profile.route> and add the Route to <main.dart>
//                 routeName: '',
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               CustomListTile(
//                 icon: Icons.home,
//                 text: 'home',
//                 routeName: Home.route,
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               CustomListTile(
//                 icon: Icons.panorama_horizontal,
//                 text: 'Losted Things',
//                 routeName: LostedThings.route,
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               CustomListTile(
//                 icon: Icons.home,
//                 text: 'Founded Things',
//                 routeName: FoundedThings.route,
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               CustomListTile(
//                 icon: Icons.settings,
//                 text: 'Settings',
//                 routeName: '',
//               ),
//             ],
//           )),
//           Column(
//             children: [
//               CustomListTile(
//                 icon: Icons.logout,
//                 text: 'Log Out',
//                 routeName: 'logout',
//                 iconColor: Colors.red,
//               ),
//               SizedBox(
//                 height: 5,
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final String routeName;
//   final iconColor;
//   CustomListTile(
//       {@required this.icon,
//       @required this.text,
//       this.routeName,
//       this.iconColor = KsecondryColor});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 50),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
//         child: ListTile(
//           tileColor: Colors.orange.withOpacity(.2),
//           title: Row(children: [
//             CustomIcon(
//               icon: icon,
//               size: 30,
//               color: iconColor,
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Text(
//               text,
//               style: TextStyle(fontSize: 20, color: KsecondryColor),
//             ),
//           ]),
//           onTap: () {
//             if (routeName == 'logout') {
//               FirebaseAuth.instance.signOut();
//               //got to sign in page
//               Navigator.pushReplacementNamed(context, Home.route);

//               return;
//             }
//             Provider.of<SearchBarData>(context, listen: false)
//                 .changeSearchBarValue('');
//             Navigator.pushNamed(context, routeName);
//           },
//         ),
//       ),
//     );
//   }
// }
