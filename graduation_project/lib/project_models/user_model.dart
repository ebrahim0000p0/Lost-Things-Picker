import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String picture;
  String displayName;
  String bio;
  String nationalNumber;
  Timestamp accountCreated;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.picture,
    this.bio,
    this.accountCreated,
    this.nationalNumber,
  });
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.data()['id'],
      name: doc.data()['name'],
      email: doc.data()['email'],
      picture: doc.data()['picture'],
      bio: doc.data()['bio'],
    );

  }


}
