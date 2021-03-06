import 'package:camhed/Admin/AdminModels/BannerModel.dart';
import 'package:camhed/Admin/AdminModels/CategoryModel.dart';
import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addCategory(CategoryModel data) {
    return _db.collection('Category').doc(data.categoryId).set(data.toMap());
  }

  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> data;
    var value =
        await _db.collection('Category').get();

    data =
        (value.docs).map((e) => CategoryModel.fromFirestore(e.data())).toList();
    return data;
  }

  Future addCountry(LocationModel data) {
    return _db.collection('Locations').add(data.toMap());
  }

  Future<List<LocationModel>> getCountry() async {
    List<LocationModel> data;
    var value = await _db.collection('Locations').get();

    data =
        (value.docs).map((e) => LocationModel.fromFirestore(e.data())).toList();
    return data;
  }

  Future addHospital(HospitalModel data) {
    return _db.collection('Hospitals').add(data.toMap());
  }

  Future<List<HospitalModel>> getHospital() async {
    LocationProvider _location = new LocationProvider();

    await _location.getLocation();
    List<HospitalModel> data;
    var value = await _db
        .collection('Hospitals')
        .where('city',
            isEqualTo: (LocationProvider.tempseleceted != null)
                ? LocationProvider.tempseleceted
                : LocationProvider.seleceted)
        .get();

    data =
        value.docs.map((e) => HospitalModel.fromFirestore(e.data())).toList();
    // print(LocationProvider.seleceted);
    return data;
  }

  Future addBanner(BannerModel data) {
    return _db.collection('Banner').add(data.toMap());
  }

  Future<BannerModel> getBanner() async {
    BannerModel data;
    var value =
        await _db.collection('Banner').doc("JjwIOhuXaqlvUlaFHUpO").get();

    data = BannerModel.fromFirestore(value.data());
    return data;
  }
}
//