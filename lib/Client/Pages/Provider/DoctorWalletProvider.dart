import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorWalletProvider with ChangeNotifier {
  AppointmentProvider _appointmentProvider = new AppointmentProvider();
  double _amount = 0;
  double _widthdraw = 0;
  List<Withdraw> _dataWithdraw = [];

  double get amount => _amount;
  double get withdraw => _widthdraw;
  List<Withdraw> get withdrwList => _dataWithdraw;

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

  updateTotalAmount(double amount) async {
    _amount = amount + _amount;
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
    // updateTotalAmount();
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

  updateWithdraw(double widthdrawAmount) async {
    if (_amount >= widthdrawAmount) {
      _amount = _amount - widthdrawAmount;
    } else {
      Fluttertoast.showToast(msg: "Not Have Enough Money");
    }
    var userId = FirebaseAuth.instance.currentUser.uid;

    await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .update({
      'total_amount': _amount,
    });

    notifyListeners();
  }

  getWithdrawList() async {
    clearWithdrawList();
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await FirebaseFirestore.instance
        .collection('DoctorWithdrawRequest')
        .doc(userId)
        .get();

    final data = WithdrawList.fromFirestore(res.data());
    print(data.withdraw);
    _dataWithdraw.addAll(data.withdraw);
    notifyListeners();
  }

  clearWithdrawList() {
    _dataWithdraw.clear();
  }

  withdrawrequest(Withdraw data) async {
    await getWithdrawList();
    var userId = FirebaseAuth.instance.currentUser.uid;
    if (_amount > 0) {
      _dataWithdraw.add(data);
      var res = WithdrawList(
        withdraw: _dataWithdraw,
      );
      await FirebaseFirestore.instance
          .collection('DoctorWithdrawRequest')
          .doc(userId)
          .set(res.toMap());

      updateWithdraw(data.amount);
    } else {
      Fluttertoast.showToast(msg: "Not Have Enough Money");
    }
  }
}

class WithdrawList {
  List<Withdraw> withdraw;

  WithdrawList({this.withdraw});

  Map<String, dynamic> toMap() {
    return {'WithdrawList': List<dynamic>.from(withdraw.map((e) => e.toMap()))};
  }

  factory WithdrawList.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return WithdrawList(
      withdraw: List<Withdraw>.from(
          firestore['WithdrawList'].map((x) => Withdraw.fromFirestore(x))),
    );
  }
}

class Withdraw {
  String name;
  String accNo;
  double amount;
  String status;
  String withdrawId;

  Withdraw({this.name, this.accNo, this.amount, this.status, this.withdrawId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'accNo.': accNo,
      'amount': amount,
      'withdrawId': withdrawId,
      'status': status,
    };
  }

  factory Withdraw.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return Withdraw(
        accNo: firestore['accNo.'],
        amount: firestore['amount'],
        status: firestore['status'],
        withdrawId: firestore['withdrawId'],
        name: firestore['name']);
  }
}
