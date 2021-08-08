class LocationModel {
  String country;
  List<String> city;

  LocationModel({this.country, this.city});

  Map<String, dynamic> toMap() {
    return {
      'Country': country,
      'City': List<dynamic>.from(city.map((e) => e)),
    };
  }

  factory LocationModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return LocationModel(
      country: firestore['Country'],
      city: List<String>.from(firestore['City'].map((x) => x)),
    );
  }
}
