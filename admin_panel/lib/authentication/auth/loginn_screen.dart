import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/testBNB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/currenUser.dart';
import 'signup_screen.dart';

enum LoginType { email, google }

class LoginnScreen extends StatefulWidget {
  static const String route = '/LoginnScreen';
  @override
  _LoginnScreenState createState() => _LoginnScreenState();
}

class _LoginnScreenState extends State<LoginnScreen> {
  var loginkey = GlobalKey<ScaffoldState>();
  var _formkey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _loginUser(
      {@required LoginType type,
      String email,
      String password,
      BuildContext context}) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString = await _currentUser.loginwithEmail(email, password);
          break;

        default:
      }

      if (_returnString == 'success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TestBNB(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      key: loginkey,
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
              buildFormBoxSignIn(),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        color: KprimaryColor,
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            _loginUser(
                                type: LoginType.email,
                                email: _email.text,
                                password: _password.text,
                                context: context);
                          } else {
                            loginkey.currentState.showSnackBar(SnackBar(
                              content: Text('Enter all Fields'),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        child: CustomText(
                          text: 'Login',
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Don’t have any account ? ',
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
                                  builder: (context) => SignnUp(),
                                ),
                              );
                            },
                            child: Text(
                              'Register here',
                              style: KTextStyle.copyWith(
                                  color: KprimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center buildFormBoxSignIn() {
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
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
