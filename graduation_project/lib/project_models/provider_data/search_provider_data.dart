import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SearchBarData extends ChangeNotifier {
  String searchBarValue = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void changeSearchBarValue(String newValue) {
    searchBarValue = newValue;
    notifyListeners();
  }

  Stream<QuerySnapshot> getDataThroughPossess() {
    final fireStore = FirebaseFirestore.instance;
    final stream = fireStore
        .collection('possess')
        .where('serialNumber', isEqualTo: searchBarValue)
        .snapshots();

    return stream;
  }

//data for search with location
  String locationCollection;
  String city = 'Alexandria';
  String quarter = 'Mohram Bk';

  void changeCollectionValue(String newValue) {
    locationCollection = newValue;
    getDataThroughLocation();
    notifyListeners();
  }

  Stream<QuerySnapshot> getDataThroughLocation() {
    final fireStore = FirebaseFirestore.instance;
//TODO menna >>
//لما تيجي تضيفي مكان الشي المفقود مثلا يكون بين المدينة و الحي مسافه
    final stream = fireStore
        .collection(locationCollection)
        .where('location', isEqualTo: city + ' ' + quarter)
        .snapshots();
    return stream;
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
}
