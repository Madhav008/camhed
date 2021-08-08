import 'package:camhed/Admin/AdminModels/CategoryModel.dart';
import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DoctorProfileProvider with ChangeNotifier {
  List<String> _country = [];
  List<String> _city = [];
  List<String> _speciality = [];
  String _name;

  List<String> get country => _country;
  List<String> get city => _city;
  List<String> get specility => _speciality;
  String get name => _name;

  getSpeciality() async {
    List<CategoryModel> data;
    var value = await FirebaseFirestore.instance.collection('Category').get();

    data =
        (value.docs).map((e) => CategoryModel.fromFirestore(e.data())).toList();

    var res = data.map((e) => e.name);

    _speciality.addAll(res);
    // print(_speciality.toList());
    notifyListeners();
  }

  getLocation() async {
    List<LocationModel> data;
    var value = await FirebaseFirestore.instance.collection('Locations').get();

    data =
        (value.docs).map((e) => LocationModel.fromFirestore(e.data())).toList();

    var res = data.map((e) => e.country);
    _country.addAll(res);

    notifyListeners();
  }

  getCity() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var docCountry = await FirebaseFirestore.instance
        .collection('DoctorProfile')
        .doc(userId)
        .get();

    List<LocationModel> data;
    var value = await FirebaseFirestore.instance
        .collection('Locations')
        .where('Country', isEqualTo: docCountry['country'])
        .get();

    data =
        (value.docs).map((e) => LocationModel.fromFirestore(e.data())).toList();

    var res = data.map((e) => e.city);

    _city.addAll(res.first);
    notifyListeners();
  }
}
