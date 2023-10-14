import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../things_model.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadData extends ChangeNotifier {
//data for search with location
  String uploadCollection;
  String city = 'Alexandria';
  String quarter = 'Mohram Bk';
  String category = 'Mobiles';
  String description = '';
  String picture = '';
  String ownerid = FirebaseAuth.instance.currentUser.uid;
  String detailedAddress = '';
  ThingsModel thingsModel;

//------- data pick img ------------------------
  File image;
  final picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
      maxWidth: 675,
      maxHeight: 400,
    );
    image = File(pickedFile.path);
    notifyListeners();
  }

//---------------------------------------------

  Future<void> uploadPic(String picture) async {
    thingsModel = ThingsModel(
      category: category,
      location: city + ' ' + quarter,
      ownerId: ownerid,
      picture: picture,
      ownerName: await getOwnerName(),
      detailedAdderss: detailedAddress,
      description: description,
    );
    firestore
        .collection(uploadCollection)
        .add(thingsModel.toJson())
        .then((value) {
      print("things Added-----------------------------------------");
      changeImageValue(null);
    }).catchError(
      (error) => print("Failed to add user: $error -----------------------"),
    );
  }

  Future<void> saveData(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image);

    uploadTask.whenComplete(() async {
      String picture = await ref.getDownloadURL();
      uploadPic(picture);
      showDialog(
          context: context,
          barrierColor: Colors.black87,
          builder: (context) {
            return Center(
              child: Container(
                width: 250,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  border: Border.all(color: KprimaryColor),
                  color: Colors.black12,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Your thing is uploaded',
                        fontSize: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(color: KprimaryColor),
                                  borderRadius: BorderRadius.circular(22)),
                            ),
                          ),
                          child: CustomText(text: 'OK'))
                    ],
                  ),
                ),
              ),
            );
          });
    }).catchError((onError) {
      print(onError);
    });
  }

  void changeImageValue(File newValue) {
    image = newValue;
    notifyListeners();
  }

  void changeCollectionValue(String newValue) {
    uploadCollection = newValue;
    // getDataThroughLocation();
    notifyListeners();
  }

  void changePictureValue(String newValue) {
    picture = newValue;
    notifyListeners();
  }

  void changeCategoryValue(String newValue) {
    category = newValue;
    notifyListeners();
  }

  void changeDescriptionValue(String newValue) {
    description = newValue;
    //notifyListeners();
  }

  void changeDetailedAddressValue(String newValue) {
    detailedAddress = newValue;
    // notifyListeners();
  }

  void changeQuarterValue(String newValue) {
    quarter = newValue;
    notifyListeners();
  }

  void changeCityValue(String newValue) {
    city = newValue;
    quarter = quarters[city][0];
    notifyListeners();
  }

  List<String> cities = [
    'Alexandria',
    'Cairo',
    'Gize',
    'Suiz',
  ];
  Map<String, List<String>> quarters = {
    'Alexandria': [
      'Mohram Bk',
      'Ramle',
      'Abees',
      'Gleem',
      'Abo Qeer',
      'Sidi Gaber',
      'Smouha',
      'Sidi Bishr',
    ],
    'Cairo': [
      'Wat ElBald',
      'El Housien',
      'El Helmia',
      'Bab Elloq',
      'Garden City'
    ],
    'Gize': [
      'El Mohandsen',
      'El Doqy',
      'Gize',
      'Ard El Liwaa',
    ],
    'Suiz': [
      'Potawfiq',
      'Al Arbaain',
      'Al Nimsa',
      'Korneesh',
      'Hisha',
      'El Sayed Hashem',
      'El Salam'
    ],
  };
  List<String> categories = [
    'Mobiles',
    'Wallets',
    'Keys',
    'Money',
    'Bags',
    'Laptops'
  ];
}
