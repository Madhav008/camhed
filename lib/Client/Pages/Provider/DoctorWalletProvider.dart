import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DoctorWalletProvider with ChangeNotifier {
  AppointmentProvider _appointmentProvider = new AppointmentProvider();
  double _amount;
  double _widthdraw;

  double get amount => _amount;
  double get withdraw => _widthdraw;

  setInitialWallet() async {
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .set({'total_amount': 0.0, 'withdraw_amount': 0.0});

    _amount = 0.0;
    _widthdraw = 0.0;

    notifyListeners();
  }

  updateTotalAmount() async {
    List<AppointmentModel> doc = _appointmentProvider.doctorAppointment;

    print(doc);
    doc.forEach((element) {
      _amount += double.parse(element.payment);
    });
    var userId = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .update({
      'total_amount': _amount,
    });

    notifyListeners();
  }

  getTotalAmount() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    updateTotalAmount();
    var res = await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .get();

    _amount = res.data()['total_amount'];

    notifyListeners();
  }

  getWithdrawAmount() async {
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .get();

    _widthdraw = double.parse(res.data()['widthdraw_amount']);

    notifyListeners();
  }

  updateWithdraw(double widthdrawAmount) {
    _amount = _amount - widthdrawAmount;
    notifyListeners();
  }
}
