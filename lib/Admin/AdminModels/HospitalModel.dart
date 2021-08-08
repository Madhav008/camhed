class HospitalModel {
  String id;
  String name;
  String location;
  String city;
  String clinicNo;
  List<String> doctorId;

  HospitalModel(
      {this.id,
      this.name,
      this.location,
      this.doctorId,
      this.city,
      this.clinicNo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': location,
      'Doctors': doctorId,
      'city': city,
      'clinicNo': clinicNo
    };
  }

  factory HospitalModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return HospitalModel(
        id: firestore['id'],
        name: firestore['name'],
        location: firestore['address'],
        city: firestore['city'],
        clinicNo: firestore['clinicNo'],
        doctorId: firestore['Doctors']);
  }
}
