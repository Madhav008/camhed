class HospitalModel {
  String name;
  String location;

  HospitalModel({this.name, this.location});

  Map<String, dynamic> toMap() {
    return {'name': name, 'Location': location};
  }

  factory HospitalModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return HospitalModel(
        name: firestore['name'], location: firestore['Location']);
  }
}
