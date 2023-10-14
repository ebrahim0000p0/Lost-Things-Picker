import 'package:admin_panel/authentication/provider/admin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(AdminModel user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('admins').doc(user.uid).set({
        'name': user.name,
        'email': FirebaseAuth.instance.currentUser.email,
        'role': 'admin',
        'id': FirebaseAuth.instance.currentUser.uid
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<AdminModel> getUserInfo(String uid) async {
    AdminModel retVal = AdminModel();

    try {
      DocumentSnapshot _snapshot =
          await _firestore.collection('admins').doc().get();
      retVal.uid = uid;
      retVal.name = _snapshot.data()['name'];
      retVal.email = _snapshot.data()['email'];
      retVal.role = _snapshot.data()['role'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
