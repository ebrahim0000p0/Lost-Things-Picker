import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/home.dart';
import '../project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/authentication/auth/root.dart';
import 'package:graduation_project/chat/pages/chats_page.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/profile/pages/edit_profile.dart';
import 'package:provider/provider.dart';

Widget appbar({String text, @required BuildContext context}) {
  return AppBar(
    // centerTitle: true,
    title: Text(text),
    iconTheme: IconThemeData(color: KprimaryColor, size: 20),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, ChatsPage.route);
          },
          icon: Icon(
            Icons.messenger,
            size: 35,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Home.route);
          },
          child: Image.asset(
            'assets/images/logo.png',
            height: 50,
            width: 50,
          ),
        ),
      ),
    ],
  );
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String routeName;
  final iconColor;
  CustomListTile(
      {@required this.icon,
      @required this.text,
      this.routeName,
      this.iconColor = KsecondryColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: ListTile(
        title: Row(children: [
          CustomIcon(
            icon: icon,
            size: 30,
            color: iconColor,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, color: KsecondryColor),
          ),
        ]),
        onTap: () {
          if (routeName == 'logout') {
            FirebaseAuth.instance.signOut();
            //got to sign in page
            Navigator.pushReplacementNamed(context, OurRoot.route);

            return;
          }
          if (routeName == 'edit') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Edit(
                  currentUserId: FirebaseAuth.instance.currentUser.uid,
                ),
              ),
            );
            return;
          }
          Provider.of<SearchBarData>(context, listen: false)
              .changeSearchBarValue('');
          Navigator.pushNamed(context, routeName);
        },
      ),
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

class CustomFloatActionButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  CustomFloatActionButton({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: KprimaryColor,
      child: Icon(
        icon,
        color: KsecondryColor,
        size: 30,
      ),
      onPressed: onPressed,
    );
  }
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

//TODO:el deep may need this to display the resaul
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
    @required this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(22)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customIcon,
          child,
        ],
      ),
    );
  }
}

class CustomFlatButton2 extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color borderColor;
  CustomFlatButton2({
    @required this.child,
    @required this.onPressed,
    this.borderColor = KprimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              side: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(22)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
