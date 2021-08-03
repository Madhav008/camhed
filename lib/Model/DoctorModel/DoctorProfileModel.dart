class DoctorProfileModel {
  String name;
  String email;
  String address;
  String idurl1;
  String idurl2;
  String status;

  DoctorProfileModel(
      {this.name,
      this.email,
      this.address,
      this.idurl1,
      this.idurl2,
      this.status});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'idurl1': idurl1,
      'idurl2': idurl2,
      'status': status
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
        status: firestore['status']);
  }
}
