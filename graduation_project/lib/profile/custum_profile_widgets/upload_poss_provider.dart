import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import '../../project_models/poss_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

String owner = FirebaseAuth.instance.currentUser.uid;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> getOwnerName() async {
  DocumentReference documentReference =
      firestore.collection('users').doc(owner);
  String ownerName;
  await documentReference.get().then((snapshot) {
    ownerName = snapshot['name'].toString();
  });
  return ownerName;
}

class UploadPossData extends ChangeNotifier {
  String uploadCollection;
  String category = 'Mobiles';
  String possId; // pass to serial num
  String description;

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
    possId = Uuid().v4().substring(24);
    PossModel possessModel = PossModel(
      category: category,
      ownerId: owner,
      picture: picture,
      serialNumber: possId,
      description: description,
      possessId: possId,
      ownerName: await getOwnerName(),
    );
    firestore
        .collection(uploadCollection)
        .add(possessModel.toJson())
        .then((value) {
      print("things Added-----------------------------------------");
      changeDescriptionValue('');
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
                width: 290,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  border: Border.all(color: KprimaryColor),
                  color: Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Your Serial Number please save it: ' + possId,
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
    }).whenComplete(() {});
  }

  void changeCollectionValue(String newValue) {
    uploadCollection = newValue;
    notifyListeners();
  }

  void changeDescriptionValue(String newValue) {
    description = newValue;
    notifyListeners();
  }

  void changeImageValue(File newValue) {
    image = newValue;
    notifyListeners();
  }

  void changeCategoryValue(String newValue) {
    category = newValue;
    notifyListeners();
  }

  List<String> categories = [
    'Mobiles',
    'Wallets',
    'Keys',
    'Money',
    'Bags',
    'Laptops'
  ];
}
