import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(UserModel user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': user.name,
        'email': FirebaseAuth.instance.currentUser.email,
        'nationalNumbar': user.nationalNumber,
        'accountCreated': Timestamp.now(),
        'picture': '',
        'id': FirebaseAuth.instance.currentUser.uid
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel retVal = UserModel();

    try {
      DocumentSnapshot _snapshot =
          await _firestore.collection('users').doc().get();
      retVal.uid = uid;
      retVal.name = _snapshot.data()['name'];
      retVal.email = _snapshot.data()['email'];
      retVal.nationalNumber = _snapshot.data()['nationalNumber'];
      retVal.accountCreated = _snapshot.data()['accountCreated'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
