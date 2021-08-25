import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:camhed/notificationservecies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorWalletProvider with ChangeNotifier {
  AppointmentProvider _appointmentProvider = new AppointmentProvider();
  int _amount = 0;
  int _widthdraw = 0;
  List<Withdraw> _dataWithdraw = [];
  int get amount => _amount;
  int get withdraw => _widthdraw;
  List<Withdraw> get withdrwList => _dataWithdraw;

  setInitialWallet() async {
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await FirebaseFirestore.instance
        .collection('DoctorWallet')
        .doc(userId)
        .set({'total_amount': 0.0, 'withdraw_amount': 0.0});

    _amount = 0;
    _widthdraw = 0;

    notifyListeners();
  }

  updateTotalAmount(int amount) async {
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

    _widthdraw = int.parse(res.data()['widthdraw_amount']);

    notifyListeners();
  }

  updateWithdraw(int widthdrawAmount) async {
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

    print(data);
    if (data != null) {
      _dataWithdraw.addAll(data.withdraw);
    }
    notifyListeners();
  }

  clearWithdrawList() {
    _dataWithdraw.clear();
  }

  withdrawrequest(Withdraw data, context) async {
    await getWithdrawList();
    var userId = FirebaseAuth.instance.currentUser.uid;
    if (_amount >= data.amount && data.amount > 0) {
      _dataWithdraw.add(data);
      var res = WithdrawList(
        withdraw: _dataWithdraw,
      );
      await FirebaseFirestore.instance
          .collection('DoctorWithdrawRequest')
          .doc(userId)
          .set(res.toMap());

      updateWithdraw(data.amount);
      Navigator.pop(context);

      NotificationServices().sendWithdrawRequestNotification();
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
  int amount;
  String status;
  String withdrawId;
  String docid;
  String transacId;
  //transection number

  Withdraw(
      {this.name,
      this.accNo,
      this.amount,
      this.status,
      this.withdrawId,
      this.transacId,
      this.docid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'accNo.': accNo,
      'amount': amount,
      'withdrawId': withdrawId,
      'status': status,
      'transacId': transacId,
      'docId': docid,
    };
  }

  factory Withdraw.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return Withdraw(
        accNo: firestore['accNo.'],
        amount: firestore['amount'],
        status: firestore['status'],
        withdrawId: firestore['withdrawId'],
        docid: firestore['docId'],
        transacId: firestore['transacId'],
        name: firestore['name']);
  }
}
