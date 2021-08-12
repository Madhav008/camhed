import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';

class AppointmentList {
  List<AppointmentModel> data;

  AppointmentList({this.data});

  Map<String, dynamic> toMap() {
    return {'appointment': List<dynamic>.from(data.map((x) => x.toMap()))};
  }

  factory AppointmentList.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return AppointmentList(
      data: List<AppointmentModel>.from(firestore['appointment']
          .map((x) => AppointmentModel.fromFirestore(x))),
    );
  }
}

class AppointmentModel {
  String doctorId;
  String userId;
  String name;
  String phone;
  String time;
  String gender;
  String date;
  String age;
  String address;
  String bookingStatus;
  String paymentStatus;
  String appointmentId;
  String doctorName;
  String doctorCategory;
  String hospitalName;
  String hospitalLocation;
  String payment;

  AppointmentModel(
      {this.name,
      this.doctorId,
      this.userId,
      this.phone,
      this.time,
      this.gender,
      this.date,
      this.age,
      this.bookingStatus,
      this.paymentStatus,
      this.appointmentId,
      this.doctorName,
      this.doctorCategory,
      this.hospitalName,
      this.hospitalLocation,
      this.payment,
      this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'doctorId': doctorId,
      'userId': userId,
      'gender': gender,
      'time': time,
      'Date': date,
      'age': age,
      'address': address,
      'bookingStatus': bookingStatus,
      'paymentStatus': paymentStatus,
      'appointmentId': appointmentId,
      'doctorName': doctorName,
      'doctorCategory': doctorCategory,
      'hospitalName': hospitalName,
      'payment': payment,
      'hospitalLocation': hospitalLocation
    };
  }

  factory AppointmentModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return AppointmentModel(
        gender: firestore['gender'],
        userId: firestore['userId'],
        name: firestore['name'],
        phone: firestore['phone'],
        age: firestore['age'],
        doctorId: firestore['doctorId'],
        date: firestore['Date'],
        address: firestore['address'],
        bookingStatus: firestore['bookingStatus'],
        paymentStatus: firestore['paymentStatus'],
        appointmentId: firestore['appointmentId'],
        doctorName: firestore['doctorName'],
        doctorCategory: firestore['doctorCategory'],
        hospitalName: firestore['hospitalName'],
        hospitalLocation: firestore['hospitalLocation'],
        payment: firestore['payment'],
        time: firestore['time']);
  }
}
