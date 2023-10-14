import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/things/found_things/found_things.dart';
import 'package:graduation_project/Screens/things/lost_things/lost_things.dart';
import '../project_models/provider_data/upload_provide_data.dart';
import 'package:graduation_project/custom_widgets/uploadimg.dart';
import 'package:provider/provider.dart';

import 'const_widget_style.dart';
import 'custom_components.dart';

class UploadBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var uploaddata = Provider.of<UploadData>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UploadImg(),
        SizedBox(
          height: 15,
        ),
        //things description
        CustomTextField(
          hintText: 'Type What You Have...',
          onchange: (value) {
            uploaddata.changeDescriptionValue(value);
          },
        ),
        SizedBox(
          height: 15.0,
        ),
        //things category
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
        // row for location
        Row(
          children: [
            Expanded(
              child: CustomDropdown(
                  value: uploaddata.city,
                  items: uploaddata.cities.map((city) {
                    return DropdownMenuItem(
                      child: Text(
                        city,
                        style: KTextStyle.copyWith(fontSize: 15),
                      ),
                      value: city,
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploaddata.changeCityValue(value);
                  },
                  icon: Icons.location_on_outlined),
            ),
            SizedBox(width: 5),
            Expanded(
              child: CustomDropdown(
                  value: uploaddata.quarter,
                  items: uploaddata.quarters[uploaddata.city].map((quarter) {
                    return DropdownMenuItem(
                      child: Text(
                        quarter,
                        style: KTextStyle.copyWith(fontSize: 15),
                      ),
                      value: quarter,
                    );
                  }).toList(),
                  onChanged: (value) {
                    uploaddata.changeQuarterValue(value);
                  },
                  icon: Icons.location_city),
            ),
          ],
        ),
        //---------------------------------------
        SizedBox(
          height: 15.0,
        ),
        //detailed address
        CustomTextField(
          hintText: 'Type Address in Detail...',
          onchange: (value) {
            uploaddata.changeDetailedAddressValue(value);
          },
        ),
        SizedBox(
          height: 15.0,
        ),
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
          onPressed: () {
            uploaddata.saveData(context);
            Navigator.pushNamed(
                context,
                uploaddata.uploadCollection == 'lost_things'
                    ? LostThings.route
                    : FoundThings.route);
          },
        )
      ],
    );
  }
}
