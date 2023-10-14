import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:provider/provider.dart';

import '../../project_models/currenUser.dart';
import 'loginn_screen.dart';

class SignnUp extends StatefulWidget {
  static const String route = '/SignupScreen';
  @override
  _SignnUpState createState() => _SignnUpState();
}

var _signupkey = GlobalKey<ScaffoldState>();
var _formkey = GlobalKey<FormState>();

class _SignnUpState extends State<SignnUp> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _nationalNumber = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context,
      String name, String nationalNumber) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString =
          await _currentUser.signUpUser(email, password, name, nationalNumber);
      if (_returnString == 'success') {
        //TODO deep edit this navigation
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(_returnString),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signupkey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 50,
              ),
              buildFormBoxSignUp(),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: KprimaryColor,
                      onPressed: () {
                        //_password.text == _confirmPassword.text
                        if (_formkey.currentState.validate()) {
                          _signUpUser(_email.text, _password.text, context,
                              _name.text, _nationalNumber.text);
                        } else {
                          _signupkey.currentState.showSnackBar(SnackBar(
                            content: Text('Enter all Fields'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: CustomText(
                        text: 'Sign Up',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'I have already an account ? ',
                                style: TextStyle(color: KsecondryColor),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginnScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login here',
                              style: KTextStyle.copyWith(
                                  color: KprimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSignUp() {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formkey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _name,
                  autofocus: true,
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return "user name can not be empty";
                    } else if (value.length < 3) {
                      return "user name must be at least 3 character long.";
                    }
                    return null;
                  },
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Enter Your Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Email can not be empty';
                    }
                    if (!RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(value)) {
                      return 'please enter valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _password,
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'password can not be empty';
                    } else if (value.length < 6) {
                      return 'password must be at least 6 character long';
                    }
                    return null;
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter Your Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPassword,
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'confirm password can not be empty';
                    }
                    if (_password.text != _confirmPassword.text) {
                      return 'password do not match';
                    }
                    return null;
                  },
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Confirm  Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _nationalNumber,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Email can not be empty';
                    }
                    if (!RegExp(
                            '(2|3)[0-9][1-9][0-1][1-9][0-3][1-9](01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)')
                        .hasMatch(value)) {
                      return 'please enter valid national number';
                    }
                    if (value.length > 14) {
                      return ' national number must be 14 character';
                    }
                    return null;
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter National Number'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
