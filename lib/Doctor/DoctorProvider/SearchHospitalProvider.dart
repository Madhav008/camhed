import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/captlizeFirstLetter.dart';

class SearchDoctorHospitalProvider with ChangeNotifier {
  List<HospitalModel> _hospital = [];

  List<HospitalModel> get hospital => _hospital;

  void resetStreams() {
    _hospital.clear();
  }

  getHospital(String query) async {
    QuerySnapshot foodData = await FirebaseFirestore.instance
        .collection("Hospitals")
        .where("name", isGreaterThanOrEqualTo: query.capitalize())
        .get();
    // print(query);

    foodData.docs.forEach((food) {
      final resultFood = HospitalModel.fromFirestore(food.data());

      _hospital.add(resultFood);
    });
    print(_hospital);
    notifyListeners();
  }
}
