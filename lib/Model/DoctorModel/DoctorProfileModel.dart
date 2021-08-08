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
  String position;
  String country;
  List<String> endTime;
  List<String> startTime;

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
      this.gender,
      this.fees,
      this.country,
      this.position,
      this.startTime,
      this.endTime,
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
      'country': country,
      'experiance': experiance,
      'position': position,
      'gender': gender,
      'fees': fees,
      'StartTime': startTime,
      'EndTime': endTime,
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
        profilepic: firestore['profilepic'],
        fees: firestore['fees'],
        gender: firestore['gender'],
        country: firestore['country'],
        position: firestore['position'],
        startTime: List<String>.from(firestore['StartTime'].map((x) => x)),
        endTime: List<String>.from(firestore['EndTime'].map((x) => x)),
        status: firestore['status']);
  }
}
