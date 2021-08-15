import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import '/captlizeFirstLetter.dart';

class DoctorSearchProvider with ChangeNotifier {
  List<DoctorProfileModel> _doctor = [];
  List<HospitalModel> _hospital = [];

  List<DoctorProfileModel> get doctor => _doctor;
  List<HospitalModel> get hospital => _hospital;

  void resetStreams() {
    _doctor.clear();
    _hospital.clear();
  }

  getDoctors(String query) async {
    QuerySnapshot docData = await FirebaseFirestore.instance
        .collection("DoctorProfile")
        .where("name", isGreaterThanOrEqualTo: "Dr " + query.capitalize())
        .get();

    docData.docs.forEach((food) {
      final resultFood = DoctorProfileModel.fromFirestore(food.data());

      _doctor.add(resultFood);
      getHospital(resultFood.doctorId);
    });
    notifyListeners();
  }

  getHospital(String docId) async {
    var hosData = await FirebaseFirestore.instance
        .collection("Hospitals")
        .where("Doctors", arrayContains: docId)
        .get();
    hosData.docs.forEach((hospital) {
      final hostData = HospitalModel.fromFirestore(hospital.data());

      _hospital.add(hostData);
    });
    notifyListeners();
  }
}
