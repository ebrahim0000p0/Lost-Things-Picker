import 'package:flutter/material.dart';

const KInputDecoration = InputDecoration(
  hintText: 'default hint text.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const KTextStyle = TextStyle(
  color: KsecondryColor,
  fontFamily: 'karla',
  fontSize: 17,
);
const Color KprimaryColor = Colors.orange;
const Color KsecondryColor = Colors.white70;
// ignore: non_constant_identifier_names
final Color KhintTextColor = Colors.grey[500];
