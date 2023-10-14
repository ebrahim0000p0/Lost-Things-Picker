import 'package:admin_panel/custom_widgets/const_widget_style.dart';
import 'package:admin_panel/custom_widgets/custom_components.dart';
import 'package:admin_panel/custom_widgets/possess_grid_view.dart';
import 'package:admin_panel/custom_widgets/things_gridview.dart';
import 'package:admin_panel/custom_widgets/users_gridview.dart';
import 'package:admin_panel/screens/notification.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestBNB extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    ThingsGridView(collectionName: 'lost_things'),
    ThingsGridView(collectionName: 'found_things'),
    //  NotificationScreen(),
    PossessGridView(),
    UsersGridView(),
  ];
  static const String route = '/testBnb';
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationState>(
      builder: (context, navigationState, child) {
        return Scaffold(
          appBar: appbar(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _widgetOptions[navigationState.getIndex()],
          ),
          bottomNavigationBar: FFNavigationBar(
            items: navigationState.getItems(),
            selectedIndex: navigationState.getIndex(),
            onSelectTab: (value) {
              navigationState.changeIndex(value);
            },
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.black12,
              selectedItemBorderColor: Colors.black12,
              selectedItemBackgroundColor: KprimaryColor,
              //  selectedItemIconColor: KsecondryColor,
              selectedItemLabelColor: KsecondryColor,
              selectedItemTextStyle: TextStyle(color: KsecondryColor),
              unselectedItemTextStyle: TextStyle(color: KsecondryColor),
            ),
          ),
        );
      },
    );
  }
}

class NavigationState extends ChangeNotifier {
  int _selectedIndex = 0;

  List<FFNavigationBarItem> _items = [
    FFNavigationBarItem(
      iconData: Icons.check_box_outline_blank_outlined,
      label: 'Lost',
    ),
    FFNavigationBarItem(
      iconData: Icons.check_box,
      label: 'Found',
    ),
    // FFNavigationBarItem(
    //   iconData: Icons.notifications,
    //   label: 'notification',
    // ),
    FFNavigationBarItem(
      iconData: Icons.apps_rounded,
      label: 'Possession',
    ),
    FFNavigationBarItem(
      iconData: Icons.person,
      label: 'User',
    ),
  ];
  getItems() => _items;
  getIndex() => _selectedIndex;
  changeIndex(newValue) {
    _selectedIndex = newValue;
    notifyListeners();
  }
}
