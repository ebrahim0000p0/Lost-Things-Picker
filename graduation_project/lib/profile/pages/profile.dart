import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/drawer.dart';
import 'package:graduation_project/custom_widgets/things_gridview.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_provider.dart';
import '../progress.dart';
import 'package:graduation_project/profile/pages/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../project_models/user_model.dart';
import 'package:graduation_project/profile/pages/possess.dart';
import 'package:provider/provider.dart';

final possesRef = FirebaseFirestore.instance.collection('posses');
final usersRef = FirebaseFirestore.instance.collection('users');
UserModel currentUser;

class Profile extends StatefulWidget {
  static const String route = '/profile';

  //TODO to compare if this profile or other profile
  final String profileId;
  Profile({this.profileId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = FirebaseAuth.instance.currentUser.uid;
  bool _isLoading = false;
  int postCount = 2;
  String PostOriantation = 'lost_things';

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //for count
        Text(
          count.toString(),
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        //for label
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
            ),
          ),
        ),
      ],
    );
  }

  //دا شكل الزرار بتاع الايديت بياخد اتنين برامتر واحد اسمه(التايتل) والتاني الفانكشن بتاعته
  editProfile() {
    //TODO this is my exception and i will reactivate this piece of code
    Future.delayed(Duration.zero, () async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Edit(
            currentUserId: currentUserId,
          ),
        ),
      );
    });
  }

  possesFunction() {
    Future.delayed(Duration.zero, () async {
      //used for upload possess form
      Provider.of<UploadPossData>(context, listen: false)
          .changeCollectionValue('possess');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Possess()),
      );
    });
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 250.0,
          height: 27.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
    );
  }

  buildProfileButton() {
    return buildButton(
      text: 'Edit Profile',
      function: editProfile,
    );
    //  }
  }

  buildPossesButton() {
    return buildButton(
      text: 'Possession',
      function: possesFunction,
    );
    // }
  }

  Widget buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.doc(widget.profileId).get(),
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
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                        //   radius: 100.0,
                        minRadius: 50,
                        maxRadius: 70,
                        backgroundColor: Colors.grey,
                        //TODO import  photo from 'user.photoUrl' data base
                        backgroundImage: userimage),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        //for post count and followers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            buildCountColumn('Posts', postCount),
                          ],
                        ),
                        // for buttons Edit Profile,posses
                        //TODO هنا هنتاح نعمل تشيك عشان لو هو مش الكرنت يوزر يستبدل العمود ب sized box
                        currentUserId != widget.profileId
                            ? SizedBox()
                            : Column(
                                //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildPossesButton(),
                                  buildProfileButton(),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              //TODO get the User Name From data base
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 12.0),
                    child: CustomText(text: user.name)),
              ),
              SizedBox(
                height: 10,
              ),
              //TODO get the bio From data base
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 2.0),
                    child: CustomText(text: user.bio)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get buildProfilePosts {
    if (PostOriantation == 'lost_things') {
      return ThingsGridView(collectionName: 'lost_things');
    } else if (PostOriantation == 'found_things') {
      return ThingsGridView(collectionName: 'found_things');
    }
  }

  setPostorientation(String PostOriantation) {
    setState(() {
      this.PostOriantation = PostOriantation;
    });
  }

//view possession of current user

  buildTogglePosts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => setPostorientation('lost_things'),
          icon: Icon(Icons.work_outline_outlined),
          color: PostOriantation == 'lost_things' ? KprimaryColor : Colors.grey,
        ),
        IconButton(
          onPressed: () => setPostorientation('found_things'),
          icon: Icon(Icons.work),
          color:
              PostOriantation == 'found_things' ? KprimaryColor : Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context: context, text: 'Profile'),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          buildProfileHeader(),
          Divider(
            height: 5.0,
          ),
          buildTogglePosts(),
          Divider(
            height: 5.0,
          ),
          Expanded(child: buildProfilePosts),
        ],
      ),
    );
  }
}
