import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/drawer.dart';
import '../progress.dart';
import '../../project_models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:graduation_project/Screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');

class Edit extends StatefulWidget {
  final String currentUserId;
  Edit({this.currentUserId});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool _displayNameValid = true;
  bool _bioValid = true;
  bool _isLoading = false;
  UserModel user;
  File file;
  PickedFile _image;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      _isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.doc(widget.currentUserId).get();
    user = UserModel.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      _isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Display Name'),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: displayNameController,
          decoration: KInputDecoration.copyWith(
            hintText: 'Update Display Name',
            errorText: _displayNameValid ? null : 'display Name too short',
          ),
        ),
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Bio'),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: bioController,
          decoration: KInputDecoration.copyWith(
            hintText: 'Update Bio',
            errorText: _bioValid ? null : 'bio text too long',
          ),
        ),
      ],
    );
  }

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
      bioController.text.trim().length > 150
          ? _bioValid = false
          : _bioValid = true;
      //todo save the new image in database
    });
    if (_displayNameValid && _bioValid) {
      usersRef.doc(widget.currentUserId).update({
        "displayName": displayNameController.text,
        "bio": bioController.text,
      });
      SnackBar snackbar = SnackBar(content: Text('Profile Updated'));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  logOut() async {
    Future.delayed(Duration.zero, () async {
      await googleSignIn.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  Future<void> handleTakePhoto() async {
    Navigator.pop(context);
    _image = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    file = File(_image.path);
    setState(() {
      this.file = file;
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    _image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      maxWidth: 675,
      maxHeight: 400,
    );
    file = File(_image.path);
    setState(() {
      this.file = file;
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Chose Photo'),
            children: [
              SimpleDialogOption(
                child: Text('Photo With Camera'),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text('Image Fom Gallery'),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
        iconTheme: IconThemeData(color: KprimaryColor, size: 20),
        actions: [
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
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: usersRef.doc(widget.currentUserId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          UserModel user = UserModel.fromDocument(snapshot.data);
          //TODO this for check if user image found

          ImageProvider userimage = snapshot.data['picture'].toString().isEmpty
              ? AssetImage('assets/images/U.png')
              : NetworkImage(
                  snapshot.data['picture'],
                );
          return ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          selectImage(context);
                        },
                        //TODO error
                        child: CircleAvatar(
                          radius: 70.0,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              file == null ? userimage : FileImage(file),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          buildDisplayNameField(),
                          SizedBox(
                            height: 20,
                          ),
                          buildBioField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: updateProfileData,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CustomText(text: 'Update Profile'),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: KprimaryColor,
                                border: Border.all(
                                  color: KprimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CustomText(text: 'Cancel'),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: KprimaryColor,
                                border: Border.all(
                                  color: KprimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  ////--------------------------------
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
