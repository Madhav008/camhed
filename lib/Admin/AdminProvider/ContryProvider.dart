import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<String> _country = [];
  List<String> _city = [];

  List<String> get country => _country;
  List<String> get city => _city;

  resetStreams() {
    _country.clear();
    notifyListeners();
  }

  clearCity() {
    _city.clear();
    notifyListeners();
  }

  getLocationData() async {
    resetStreams();
    var res = await FirebaseFirestore.instance.collection("Locations").get();
    res.docs.forEach((loc) {
      final data = LocationModel.fromFirestore(loc.data());
      _country.add(data.country);
    });
  }

  addCountry(LocationModel data) async {
    await FirebaseFirestore.instance
        .collection('Locations')
        .doc(data.country)
        .set(data.toMap());

    _country.add(data.country);
    notifyListeners();
  }

  getCity(String country) async {
    clearCity();
    var res = await FirebaseFirestore.instance
        .collection('Locations')
        .where('Country', isEqualTo: country)
        .get();

    res.docs.forEach((loc) {
      final city = LocationModel.fromFirestore(loc.data());
      _city.addAll(city.city);
    });
    notifyListeners();
  }

  changeCity(LocationModel data) async {
    _city.addAll(data.city);

    FirebaseFirestore.instance
        .collection('Locations')
        .doc(data.country)
        .update({'City': List<dynamic>.from(data.city.map((e) => e))});
    notifyListeners();
  }
}
