import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String myId = auth.currentUser.uid;
String myUsername = auth.currentUser.displayName;
String mypicture =
    "https://firebasestorage.googleapis.com/v0/b/lost-things-picker.appspot.com/o/Screenshot%20(100).png?alt=media&token=ead6dc0f-9d69-4995-bf6f-9356019b591e";
