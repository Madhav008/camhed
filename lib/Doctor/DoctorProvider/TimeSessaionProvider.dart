import 'dart:math';

import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSessionProvider with ChangeNotifier {
  List<String> _start_time = [];
  List<String> _end_time = [];

  List<String> get startTime => _start_time;
  List<String> get endTime => _end_time;

  resetStreams() {
    _start_time.clear();
    _end_time.clear();
  }

  getProfileData() async {
    resetStreams();
    DoctorProfileModel data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await FirebaseFirestore.instance
        .collection('DoctorProfile')
        .doc(userId)
        .get();
    data = DoctorProfileModel.fromFirestore(res.data());

    final start = data.startTime;
    final end = data.endTime;

    _start_time.addAll(start);
    _end_time.addAll(end);

    notifyListeners();
  }

  updateTime(String starttime, String endTime) {
    _start_time.add(starttime);
    _end_time.add(endTime);

    var userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('DoctorProfile').doc(userId).update({
      "StartTime": List<dynamic>.from(_start_time.map((e) => e.toString())),
      "EndTime": List<dynamic>.from(_end_time.map((e) => e.toString()))
    });
    getProfileData();

    notifyListeners();
  }

  removeSession(var startTime, var endTime) {
    _start_time.remove(startTime);
    _end_time.remove(endTime);

    var userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('DoctorProfile').doc(userId).update({
      "StartTime": List<dynamic>.from(_start_time.map((e) => e.toString())),
      "EndTime": List<dynamic>.from(_end_time.map((e) => e.toString()))
    });
    notifyListeners();
  }
}
