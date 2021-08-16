import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DoctorStatusProvider with ChangeNotifier {
  List<DoctorProfileModel> _doctorData = [];

  List<DoctorProfileModel> get doctorData => _doctorData;

  resetStreams() {
    _doctorData.clear();
    notifyListeners();
  }

  getDoctorData() async {
    resetStreams();

    var res = await FirebaseFirestore.instance
        .collection('DoctorProfile')
        .where('status', isNull: true)
        .get();

    res.docs.forEach((doc) {
      final docData = DoctorProfileModel.fromFirestore(doc.data());
      _doctorData.add(docData);
    });

    print(_doctorData.toList());
    notifyListeners();
  }
}
