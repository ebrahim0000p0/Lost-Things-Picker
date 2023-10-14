import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import '../../project_models/currenUser.dart';
import 'package:provider/provider.dart';

import 'loginn_screen.dart';

enum AuthStatus { notloggedIn, logggedIn }

class OurRoot extends StatefulWidget {
  static const String route = '/root';
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notloggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();

    if (_returnString == 'success') {
      setState(() {
        _authStatus = AuthStatus.logggedIn;
      });
    }

    //
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notloggedIn:
        retVal = LoginnScreen();
        break;
      case AuthStatus.logggedIn:
        retVal = Home();
        break;
      default:
    }

    return retVal;
  }
}
