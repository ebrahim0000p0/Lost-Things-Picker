import 'package:flutter/material.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_img.dart';
import 'package:graduation_project/profile/custum_profile_widgets/upload_poss_provider.dart';
import 'package:graduation_project/profile/pages/possess.dart';
import 'package:provider/provider.dart';

class UploadPossesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UploadPossData>(
      builder: (BuildContext context, uploaddata, Widget child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UploadPossImg(),
            SizedBox(
              height: 15,
            ),
            //possess description
            CustomTextField(
              hintText: 'Type Your Description',
              onchange: (value) {
                uploaddata.changeDescriptionValue(value);
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            //possess category
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                      value: uploaddata.category,
                      items: uploaddata.categories.map((city) {
                        return DropdownMenuItem(
                          child: Text(
                            city,
                            style: KTextStyle.copyWith(fontSize: 15),
                          ),
                          value: city,
                        );
                      }).toList(),
                      onChanged: (value) {
                        uploaddata.changeCategoryValue(value);
                      },
                      icon: Icons.arrow_downward),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            //---------------------------------------

            TextButton(
              child: CustomText(
                text: 'save',
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: KprimaryColor),
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
              onPressed: () async {
                await uploaddata.saveData(context);
                //TODO this that problem
                Navigator.pushNamed(context, Possess.route);
              },
            )
          ],
        );
      },
    );
  }
}

// // row for location
//       Row(
//         children: [
//           Expanded(
//             child: CustomDropdown(
//                 value: uploaddata.city,
//                 items: uploaddata.cities.map((city) {
//                   return DropdownMenuItem(
//                     child: Text(
//                       city,
//                       style: KTextStyle.copyWith(fontSize: 15),
//                     ),
//                     value: city,
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   uploaddata.changeCityValue(value);
//                 },
//                 icon: Icons.location_on_outlined),
//           ),
//           SizedBox(width: 5),
//           Expanded(
//             child: CustomDropdown(
//                 value: uploaddata.quarter,
//                 items: uploaddata.quarters[uploaddata.city].map((quarter) {
//                   return DropdownMenuItem(
//                     child: Text(
//                       quarter,
//                       style: KTextStyle.copyWith(fontSize: 15),
//                     ),
//                     value: quarter,
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   uploaddata.changeQuarterValue(value);
//                 },
//                 icon: Icons.location_city),
//           ),
//         ],
//       ),
