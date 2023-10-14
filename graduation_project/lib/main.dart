import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import 'project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/Screens/things/found_things/found_things.dart';
import 'package:graduation_project/Screens/things/lost_things/lost_things.dart';
import 'package:graduation_project/Screens/things/search/search_location_screen.dart';
import 'project_models/provider_data/upload_provide_data.dart';
import 'package:graduation_project/Screens/welcome.dart';
import 'package:graduation_project/chat/pages/chat_page.dart';
import 'package:graduation_project/chat/pages/chats_page.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_provider.dart';
import 'package:graduation_project/profile/pages/possess.dart';
import 'package:graduation_project/profile/pages/upload_poss_screen.dart';
import 'project_models/provider_data/user_data.dart';
import 'package:provider/provider.dart';
import 'Screens/things/found_things/Upload_Found.dart';
import 'Screens/things/lost_things/Upload_Lost.dart';
import 'authentication/auth/loginn_screen.dart';
import 'authentication/auth/root.dart';
import 'authentication/auth/signup_screen.dart';
import 'project_models/currenUser.dart';
import 'profile/pages/profile.dart';

String userID = FirebaseAuth.instance.currentUser.uid;

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
        ChangeNotifierProvider<SearchBarData>(
          create: (context) => SearchBarData(),
        ),
        ChangeNotifierProvider<UploadData>(
          create: (context) => UploadData(),
        ),
        ChangeNotifierProvider<UploadPossData>(
          create: (context) => UploadPossData(),
        ),
        Provider(create: (context) => UserProvider()),
        ChangeNotifierProvider<CurrentUser>(
          create: (context) => CurrentUser(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(),
        debugShowCheckedModeBanner: false,
        title: 'Lost Things Picker',
        initialRoute: Welcome.route,
        routes: {
          Welcome.route: (context) => Welcome(),
          Home.route: (context) => Home(),
          LostThings.route: (context) => LostThings(),
          FoundThings.route: (context) => FoundThings(),
          SearchLocationScreen.route: (context) => SearchLocationScreen(),
          ChatsPage.route: (context) => ChatsPage(),
          UploadLost.route: (context) => UploadLost(),
          UploadPosses.route: (context) => UploadPosses(),
          UploadFound.route: (context) => UploadFound(),
          Profile.route: (context) => Profile(
                profileId: userID,
              ),
          SignnUp.route: (context) => SignnUp(),
          LoginnScreen.route: (context) => LoginnScreen(),
          OurRoot.route: (context) => OurRoot(),
          Possess.route: (context) => Possess(),
        },
      ),
    );
  }

  ChatPage buildChatPage() => ChatPage(uid: null);
}
