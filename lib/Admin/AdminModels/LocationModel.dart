class LocationModel {
  String name;


  LocationModel({this.name});

  Map<String, dynamic> toMap() {
    return {'Country': name};
  }

  factory LocationModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return LocationModel(
      name: firestore['Country'],
    );
  }
}

