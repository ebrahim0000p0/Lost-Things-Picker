import 'package:admin_panel/authentication/auth/root.dart';
import 'package:admin_panel/screens/home.dart';
import 'package:admin_panel/screens/things/found_things.dart';
import 'package:admin_panel/screens/things/lost_things.dart';
import 'package:admin_panel/screens/things/possess.dart';
import 'package:admin_panel/screens/users.dart';
import 'package:admin_panel/testBNB.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationState>(
            create: (context) => NavigationState()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(),
        debugShowCheckedModeBanner: false,
        title: 'LTP Admin Panel',
        initialRoute: TestBNB.route,
        routes: {
          TestBNB.route: (context) => TestBNB(),
          Home.route: (context) => Home(),
          LostThings.route: (context) => LostThings(),
          FoundThings.route: (context) => FoundThings(),
          Possess.route: (context) => Possess(),
          Users.route: (context) => Users(),
          OurRoot.route: (context) => OurRoot(),
        },
      ),
    );
  }
}
