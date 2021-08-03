import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorServices {

 FirebaseFirestore _db = FirebaseFirestore.instance;
   Future<void> addUser(String userId,DoctorProfileModel user) {
    return _db.collection('DoctorProfile').doc(userId).set(user.toMap());
  }


  Future<DoctorProfileModel> fetchUser(String userId) {
    return _db
        .collection('DoctorProfile')
        .doc(userId)
        .get()
        .then((value) => DoctorProfileModel.fromFirestore(value.data()));
  }
}