import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {
  final uid = FirebaseAuth.instance.currentUser.uid;
//TODO after ali complete his tasks will uncomment line 6 and change the <doc()> params to <uid>

  Stream<DocumentSnapshot> stream() {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }
}
