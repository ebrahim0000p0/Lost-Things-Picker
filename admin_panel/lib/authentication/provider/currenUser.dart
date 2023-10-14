import 'package:admin_panel/authentication/auth/database.dart';
import 'package:admin_panel/authentication/auth/root.dart';
import 'package:admin_panel/authentication/provider/admin_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CurrentUser extends ChangeNotifier {
  AdminModel _currentUser = AdminModel();
  AuthStatus _authStatus;
  AdminModel get getUserProvider => _currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus get authstatus => _authStatus;

  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      User _firebaseuser = _auth.currentUser;
      if (_firebaseuser != null) {
        _currentUser = await Database().getUserInfo(_firebaseuser.uid);

        if (_currentUser != null) {
          retVal = 'success';
        }
      }
    } catch (e) {
      print(e.message);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String name, String role) async {
    AdminModel _user = AdminModel();

    String retVal = 'error';

    try {
      UserCredential _auhtResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _auhtResult.user.uid;
      _user.email = _auhtResult.user.uid;
      _user.name = name;
      _user.role = role;

      String _returnString = await Database().createUser(_user);
      if (_returnString == 'success') {
        retVal = 'success';
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';

    try {
      await _auth.signOut();
      _currentUser = AdminModel();
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> loginwithEmail(String email, String password) async {
    String retVal = 'error';

    try {
      UserCredential _auhtResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentUser = await Database().getUserInfo(_auhtResult.user.uid);

      if (_currentUser != null) {
        retVal = 'success';
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print('e');
    }
    return retVal;
  }
}
