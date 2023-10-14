import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadPossImg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UploadImgState();
  }
}

class UploadImgState extends State<UploadPossImg> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadPossData>(
      builder: (context, uploadData, child) {
        return Center(
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 75,
                backgroundImage: uploadData.image == null
                    ? AssetImage('assets/images/U.png')
                    : FileImage(File(uploadData.image.path)),
              ),
              Positioned(
                  bottom: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 32,
                        autofocus: true,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        }),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget bottomSheet() {
    return Consumer<UploadPossData>(
      builder: (context, uploadData, child) {
        return Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              CustomText(text: 'Choose Photo From:'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () {
                        uploadData.getImage(ImageSource.camera);
                      },
                      label: Text('Camera'),
                      icon: Icon(Icons.camera_alt)),
                  TextButton.icon(
                      onPressed: () {
                        uploadData.getImage(ImageSource.gallery);
                      },
                      label: Text('Gallery'),
                      icon: Icon(Icons.folder))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
