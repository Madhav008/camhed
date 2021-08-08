import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Future addUser(String userId, DoctorProfileModel user) {
    return _db.collection('DoctorProfile').doc(userId).set(user.toMap());
  }

  Future<DoctorProfileModel> fetchUser(String userId) {
    return _db
        .collection('DoctorProfile')
        .doc(userId)
        .get()
        .then((value) => DoctorProfileModel.fromFirestore(value.data()));
  }

  Future<List<DoctorProfileModel>> fetchCategoryDoctor(String category) async {
    List<DoctorProfileModel> data;
    await _db
        .collection('DoctorProfile')
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      data = (value.docs)
          .map((e) => DoctorProfileModel.fromFirestore(e.data()))
          .toList();
    });
    return data;
  }
}
