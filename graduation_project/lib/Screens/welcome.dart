import 'package:flutter/material.dart';
import 'package:graduation_project/authentication/auth/root.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Welcome extends StatelessWidget {
  static const String route = '/welcome';
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: OurRoot(),
      duration: 1000,
      imageSize: 140,
      imageSrc: "assets/images/logo1.jpg",
      text: "Welcome To Your LTP",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
        fontFamily: 'karla',
        color: KsecondryColor,
      ),
      backgroundColor: KprimaryColor,
    );
  }
}
