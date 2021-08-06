import 'package:camhed/Admin/AdminModels/CategoryModel.dart';
import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DoctorProfileProvider with ChangeNotifier {
  List<String> _city = [];
  List<String> _speciality = [];
  String _name;

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

    var res = data.map((e) => e.name);
    _city.addAll(res);

    notifyListeners();
  }
}
