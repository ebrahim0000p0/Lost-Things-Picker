import 'package:flutter/material.dart';
import 'package:graduation_project/Screens/things/search/search_location_listview.dart';
import '../../../project_models/provider_data/search_provider_data.dart';
import 'package:graduation_project/custom_widgets/const_widget_style.dart';
import 'package:graduation_project/custom_widgets/custom_components.dart';
import 'package:graduation_project/custom_widgets/drawer.dart';
import 'package:provider/provider.dart';

class SearchLocationScreen extends StatelessWidget {
  static const String route = '/search_location_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarData>(
      builder: (context, searchBarData, child) {
        return Scaffold(
          appBar: appbar(
              text: searchBarData.locationCollection == 'lost_things'
                  ? 'Lost Things'
                  : 'Found Things',
              context: context),
          drawer: CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: KprimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: KprimaryColor),
                  ),
                  child: CustomText(
                    text: 'Search with location',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CustomDropdown(
                        value: searchBarData.city,
                        items: searchBarData.cities.map((city) {
                          return DropdownMenuItem(
                            child: Text(
                              city,
                              style: KTextStyle.copyWith(fontSize: 15),
                            ),
                            value: city,
                          );
                        }).toList(),
                        onChanged: (value) {
                          searchBarData.changeCityValue(value);
                        },
                        icon: Icons.location_on_outlined),
                    SizedBox(width: 5),
                    CustomDropdown(
                        value: searchBarData.quarter,
                        items: searchBarData.quarters[searchBarData.city]
                            .map((quarter) {
                          return DropdownMenuItem(
                            child: Text(
                              quarter,
                              style: KTextStyle.copyWith(fontSize: 15),
                            ),
                            value: quarter,
                          );
                        }).toList(),
                        onChanged: (value) {
                          searchBarData.changeQuarterValue(value);
                        },
                        icon: Icons.location_city),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                SearchLocationCardView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
