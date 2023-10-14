import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';
import 'package:graduation_project/authentication/auth/root.dart';
import 'user_model.dart';

class CurrentUser extends ChangeNotifier {
  UserModel _currentUser = UserModel();
  AuthStatus _authStatus;
  UserModel get getUserProvider => _currentUser;
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
      String email, String password, String name, String nationalNumber) async {
    UserModel _user = UserModel();

    String retVal = 'error';

    try {
      UserCredential _auhtResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _auhtResult.user.uid;
      _user.email = _auhtResult.user.uid;
      _user.name = name;
      _user.nationalNumber = nationalNumber;

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
      _currentUser = UserModel();
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

  Future<String> loginwithGoogle() async {
    String retVal = 'error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _auhtResult =
          await _auth.signInWithCredential(authCredential);
      UserModel _user = UserModel();

      if (_auhtResult.additionalUserInfo.isNewUser) {
        _user.uid = _auhtResult.user.uid;
        _user.email = _auhtResult.user.email;
        _user.name = _auhtResult.user.displayName;
        Database().createUser(_user);
      }

      _currentUser = await Database().getUserInfo(_auhtResult.user.uid);

      if (_currentUser != null) {
        retVal = 'success';
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }
}
