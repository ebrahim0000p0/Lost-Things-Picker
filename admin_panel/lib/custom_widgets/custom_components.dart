import 'package:admin_panel/authentication/auth/root.dart';
import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appbar(@required BuildContext context) {
  return AppBar(
    title: Text('Admin Panel'),
    // centerTitle: true,
    iconTheme: IconThemeData(color: KprimaryColor, size: 20),
    actions: [
      // IconButton(
      //   onPressed: () {
      //     FirebaseAuth.instance.signOut();
      //     Navigator.pushReplacementNamed(context, OurRoot.route);
      //   },
      //   icon: CustomIcon(icon: Icons.logout, color: Colors.red),
      // ),
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: TextButton(
          onPressed: () {},
          child: Image.asset(
            'assets/images/logo.png',
            height: 50,
            width: 50,
          ),
        ),
      )
    ],
  );
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function onchange;
  CustomTextField({@required this.hintText, @required this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: KhintTextColor),
      keyboardType: TextInputType.text,
      decoration: KInputDecoration.copyWith(
        hintText: hintText,
      ),
      onChanged: onchange,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  CustomText({
    @required this.text,
    this.fontSize = 17,
    this.color = KsecondryColor,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KTextStyle.copyWith(fontSize: fontSize, color: color),
      textAlign: TextAlign.center,
    );
  }
}

class CustomOutLineText extends StatelessWidget {
  final String text;
  CustomOutLineText({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: CustomText(text: text),
      decoration: BoxDecoration(
          border: Border.all(color: KprimaryColor),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem> items;
  final Function onChanged;
  final IconData icon;
  CustomDropdown(
      {@required this.value,
      @required this.items,
      @required this.onChanged,
      @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DropdownButtonFormField(
      icon: Icon(icon),
      iconEnabledColor: KsecondryColor,
      style: TextStyle(
        color: KsecondryColor,
      ),
      decoration: KInputDecoration,
      value: value,
      items: items,
      onChanged: onChanged,
    ));
  }
}

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  CustomIcon({@required this.icon, this.size, this.color = KprimaryColor});
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageLink;
  final String title;
  final String subTitle;
  final Widget trailing;
  CustomCard(
      {@required this.imageLink,
      @required this.title,
      @required this.subTitle,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 2,
                child: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 60,
              color: KprimaryColor,
              child: ListTile(
                dense: true,
                title: Text(title),
                subtitle: Text(subTitle),
                trailing: trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color borderColor;
  final CustomIcon customIcon;
  CustomFlatButton({
    @required this.child,
    @required this.onPressed,
    this.borderColor = KprimaryColor,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: borderColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customIcon ?? Container(),
          child,
        ],
      ),
    );
  }
}
