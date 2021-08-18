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
  List<AppointmentModel> _doctorAppointmentHistory = <AppointmentModel>[];

  List<AppointmentModel> _doctorAppointmentPending = <AppointmentModel>[];
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
  List<AppointmentModel> get doctorAppointmentHistory =>
      _doctorAppointmentHistory;
  List<AppointmentModel> get doctorAppointmentPending =>
      _doctorAppointmentPending;
  String get doctorId => _doctorId;
  bool get isApiCallProcess => _isApiCallProcess;
  bool get paymentDone => _paymentDone;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser.uid;

  //Make Appointment in The User Collection
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

  //Main Function To Check And Verify If Payment is Done
  //Then Add The Doctor Appointmet in collection

  setAppointment(AppointmentModel data, String doctorId) {
    _isApiCallProcess = true;
    _de.add(data);

    var appListData = AppointmentList(data: _de);
    makeAppointment(appListData);

    notifyListeners();
  }

  //Sub Function Get Doctor Appointments For User
  makeDoctorAppointment(AppointmentList data, String doctorId) async {
    await _db.collection("DoctorAppointments").doc(doctorId).set(data.toMap());
    // print(data.data);
  }

  getDoctorAppointmentsForUser(String userId, AppointmentModel datass) async {
    clearDocList();
    AppointmentList data;

    var res = await _db.collection('DoctorAppointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());

    // print(data.toMap());
    if (data != null) {
      _doctorAppointment.addAll(data.data);
      _doctorAppointment.add(datass);
    } else {
      _doctorAppointment.add(datass);
    }

    var docAppointment = AppointmentList(data: _doctorAppointment);
    // print(docAppointment.data.length);

    makeDoctorAppointment(docAppointment, userId);
    notifyListeners();
  }

  getDoctorAppointments() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('DoctorAppointments').doc(userId).get();

    final data = AppointmentList.fromFirestore(res.data());
    clearDocList();
    clearDocPendingList();
    clearDocHistoryList();
    _doctorAppointment.addAll(data.data);

    getDoctorAppointmentsPending();
  }

  getDoctorAppointmentsPending() {
    clearDocPendingList();
    clearDocHistoryList();
    // getDoctorAppointments();
    _doctorAppointment.forEach((element) {
      // print(element.bookingStatus);
      if (element.bookingStatus == 'Pending') {
        _doctorAppointmentPending.add(element);
        // print("Madhav");

        // print(_doctorAppointmentHistory.toList());
      } else {
        _doctorAppointmentHistory.add(element);
      }
    });

    notifyListeners();
  }

  getAppointments() async {
    clearList();
    AppointmentList data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('Appointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());
    if (data != null) {
      _de.addAll(data.data);
    }

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
  }

  clearDocHistoryList() {
    _doctorAppointmentHistory.clear();
  }

  clearDocPendingList() {
    _doctorAppointmentPending.clear();
  }
}
