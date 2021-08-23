import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorServices {
  LocationProvider _location = new LocationProvider();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Future addUser(String userId, DoctorProfileModel user) {
    return _db.collection('DoctorProfile').doc(userId).set(user.toMap());
  }

  Future<DoctorProfileModel> fetchUser(String userId) async {
    DoctorProfileModel data;
    await _db.collection('DoctorProfile').doc(userId).get().then((value) {
      data = DoctorProfileModel.fromFirestore(value.data());
    });
    return data;
  }

  Future<List<DoctorProfileModel>> fetchCategoryDoctor(String category) async {
    List<DoctorProfileModel> data;
    await _location.getLocation();

    await _db
        .collection('DoctorProfile')
        .where('category', isEqualTo: category)
        .where('address', isEqualTo: (LocationProvider.tempseleceted!=null)?LocationProvider.tempseleceted:LocationProvider.seleceted)
        .get()
        .then((value) {
      data = (value.docs)
          .map((e) => DoctorProfileModel.fromFirestore(e.data()))
          .toList();
    });
    return data;
  }

  Future<List<String>> fetchHospitalDoctor(String hospitalId) async {
    // List<DoctorProfileModel> data = [];
    List<HospitalModel> hospitalData;
    // DoctorProfileModel docData;
    await _db
        .collection('Hospitals')
        .where('id', isEqualTo: hospitalId)
        .get()
        .then((value) {
      hospitalData = (value.docs)
          .map((e) => HospitalModel.fromFirestore(e.data()))
          .toList();

      // hospitalData.first.doctorId.forEach((element) async {
      //   docData = await fetchUser(element);
      //   // print(element);
      //   print(docData.toMap());
      //    data.add(docData);
      // });
    });

    return hospitalData.first.doctorId;
  }
}
