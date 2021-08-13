import 'package:camhed/Model/AppointmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentProvider with ChangeNotifier {
  String _name;
  String _phone;
  String _time;
  String _gender;
  String _date;
  String _age;
  String _address;
  List<AppointmentModel> _de = <AppointmentModel>[];
  List<AppointmentModel> _doctorAppointment = <AppointmentModel>[];

  String _doctorId;
  bool _isApiCallProcess = false;
  bool _paymentDone = true;

  String get name => _name;
  String get phone => _phone;
  String get time => _time;
  String get gender => _gender;
  String get date => _date;
  String get age => _age;
  String get address => _address;
  List<AppointmentModel> get de => _de;
  List<AppointmentModel> get doctorAppointment => _doctorAppointment;

  String get doctorId => _doctorId;
  bool get isApiCallProcess => _isApiCallProcess;
  bool get paymentDone => _paymentDone;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser.uid;

  makeAppointment(AppointmentList data) {
    _db.collection("Appointments").doc(userId).set(data.toMap());
    Fluttertoast.showToast(
        msg: "Appointment Created  ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    setApiCall();
  }

  setAppointment(AppointmentModel data, String doctorId) {
    _isApiCallProcess = true;
    _de.add(data);

    var appListData = AppointmentList(data: _de);
    makeAppointment(appListData);

    if (paymentDone) {
      getDoctorAppointmentsForUser(doctorId, data);
    }

    notifyListeners();
  }

  makeDoctorAppointment(AppointmentList data, String doctorId) async {
    await _db.collection("DoctorAppointments").doc(doctorId).set(data.toMap());
    // print(data.data);
  }

  getDoctorAppointmentsForUser(String userId, AppointmentModel datass) async {
    clearDocList();
    AppointmentList data;

    var res = await _db.collection('DoctorAppointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());

    print(data.toMap());
    _doctorAppointment.addAll(data.data);
    // print(_doctorAppointment);
    _doctorAppointment.add(datass);

    var docAppointment = AppointmentList(data: _doctorAppointment);
    print(docAppointment.data.length);

    makeDoctorAppointment(docAppointment, userId);
    notifyListeners();
  }

  getDoctorAppointments() async {
    clearDocList();
    AppointmentList data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('DoctorAppointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());

    _doctorAppointment.addAll(data.data);

    notifyListeners();
  }

  getAppointments() async {
    clearList();
    AppointmentList data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('Appointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());

    _de.addAll(data.data);

    notifyListeners();
  }

  void setApiCall() {
    _isApiCallProcess = !_isApiCallProcess;
    notifyListeners();
  }

  clearList() {
    _de.clear();
    notifyListeners();
  }

  clearDocList() {
    _doctorAppointment.clear();
    notifyListeners();
  }
}
