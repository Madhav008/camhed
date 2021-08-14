import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import '/captlizeFirstLetter.dart';

class DoctorSearchProvider with ChangeNotifier {
  List<DoctorProfileModel> _doctor = [];

  List<DoctorProfileModel> get doctor => _doctor;
  void resetStreams() {
    _doctor.clear();
  }

  getDoctors(String query) async {
    QuerySnapshot docData = await FirebaseFirestore.instance
        .collection("DoctorProfile")
        .where("name", isGreaterThanOrEqualTo: "Dr " + query.capitalize())
        .get();

    docData.docs.forEach((food) {
      final resultFood = DoctorProfileModel.fromFirestore(food.data());

      _doctor.add(resultFood);
    });
    notifyListeners();
  }
}
