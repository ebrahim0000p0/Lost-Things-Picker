import 'dart:ui';

import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/testBNB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/currenUser.dart';

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
  TextEditingController _role = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context,
      String name, String role) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString =
          await _currentUser.signUpUser(email, password, name, role);
      if (_returnString == 'success') {
        Navigator.pushReplacementNamed(context, TestBNB.route);
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
                      height: 10,
                    ),
                    RaisedButton(
                      color: KprimaryColor,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          _signUpUser(_email.text, _password.text, context,
                              _name.text, _role.text);
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
                                  builder: (context) => TestBNB(),
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
                      KInputDecoration.copyWith(hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _email,
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
                  controller: _role,
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'role can not be empty';
                    }
                    return null;
                  },
                  decoration:
                      KInputDecoration.copyWith(hintText: 'role : Admin'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
