class AppointmentModel {
  String name;
  String phone;
  String time;
  String gender;
  String date;
  String age;
  String address;
  AppointmentModel(
      {this.name,
      this.phone,
      this.time,
      this.gender,
      this.date,
      this.age,
      this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'gender': gender,
      'time': time,
      'Date': date,
      'age': age,
      'address': address,
    };
  }

  factory AppointmentModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return AppointmentModel(
        gender: firestore['gender'],
        name: firestore['name'],
        phone: firestore['phone'],
        age: firestore['age'],
        date: firestore['date'],
        address: firestore['address'],
        time: firestore['time']);
  }
}
