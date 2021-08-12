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
  String _doctorId;
  bool _isApiCallProcess = false;

  String get name => _name;
  String get phone => _phone;
  String get time => _time;
  String get gender => _gender;
  String get date => _date;
  String get age => _age;
  String get address => _address;
  List<AppointmentModel> get de => _de;
  String get doctorId => _doctorId;
  bool get isApiCallProcess => _isApiCallProcess;
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

  setAppointment(AppointmentModel data) {
    _isApiCallProcess = true;
    _de.add(data);
    var appListData = AppointmentList(data: _de);
    makeAppointment(appListData);
    notifyListeners();
  }

  getAppointments() async {
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
}
