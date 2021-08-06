import 'package:camhed/Model/DoctorModel/SessionTimeModel.dart';

class DoctorProfileModel {
  String name;
  String email;
  String address;
  String idurl1;
  String idurl2;
  String idBack;
  String status;
  String category;
  String phone;
  String gender;
  String experiance;
  String profilepic;
  String fees;
  String hospital;
  String position;
  List<SessionTimeModel> time;

  DoctorProfileModel(
      {this.name,
      this.email,
      this.address,
      this.idurl1,
      this.idBack,
      this.idurl2,
      this.phone,
      this.category,
      this.experiance,
      this.profilepic,
      this.time,
      this.hospital,
      this.position,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'idurl1': idurl1,
      'idurl2': idurl2,
      'idBack': idBack,
      'status': status,
      'category': category,
      'phone': phone,
      'experiance': experiance,
      'hospital': hospital,
      'position': position,
      'time': List<dynamic>.from(time.map((e) => e)),
      'profilepic': profilepic,
    };
  }

  factory DoctorProfileModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return DoctorProfileModel(
        name: firestore['name'],
        email: firestore['email'],
        address: firestore['address'],
        idurl1: firestore['idurl1'],
        idurl2: firestore['idurl2'],
        idBack: firestore['idBack'],
        category: firestore['category'],
        experiance: firestore['experiance'],
        phone: firestore['phone'],
        hospital: firestore['hospital'],
        profilepic: firestore['profilepic'],
        position: firestore['position'],
        time: List<SessionTimeModel>.from(firestore['time'].map((x) => x)),
        status: firestore['status']);
  }
}
