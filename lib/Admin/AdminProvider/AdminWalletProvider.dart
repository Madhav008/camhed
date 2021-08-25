import 'package:camhed/Client/Pages/Provider/DoctorWalletProvider.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminWalletProvider with ChangeNotifier {
  List<Withdraw> _docWithrawals = [];
  DoctorProfileModel _docDetails;
  List<Withdraw> _tempDocList = [];
  List<Withdraw> _dataWithdraw = [];

  List<Withdraw> get docWithdrawls => _docWithrawals;
  DoctorProfileModel get docDetails => _docDetails;
  List<Withdraw> get withdrwList => _dataWithdraw;
  List<Withdraw> get tempDocList => _tempDocList;
  clearList() {
    _docWithrawals.clear();
    notifyListeners();
  }

  getAllDocWithrawls() async {
    clearList();
    var _db = FirebaseFirestore.instance;
    var res = await _db.collection('DoctorWithdrawRequest').get();
    clearList();

    final data =
        (res.docs).map((e) => WithdrawList.fromFirestore(e.data())).toList();

    data.forEach((element) {
      // _docWithrawals.addAll(element.withdraw);
      element.withdraw.forEach((e) {
        if (e.status == "Pending") {
          _docWithrawals.add(e);
        } else {
          _tempDocList.add(e);
        }
      });
    });

    notifyListeners();
  }

  getDocDetails(String id) async {
    var _db = FirebaseFirestore.instance;
    var res = await _db.collection('DoctorProfile').doc(id).get();
    final data = DoctorProfileModel.fromFirestore(res.data());

    _docDetails = data;

    notifyListeners();
  }

  // getWithdrawList(String userId) async {
  //   clearWithdrawList();

  //   var res = await FirebaseFirestore.instance
  //       .collection('DoctorWithdrawRequest')
  //       .doc(userId)
  //       .get();

  //   final data = WithdrawList.fromFirestore(res.data());

  //   if (data != null) {
  //     _dataWithdraw.addAll(data.withdraw);
  //   }
  //   notifyListeners();
  // }

  withdrawrequest(Withdraw data, String userId) async {
    clearWithdrawList();

    _docWithrawals.remove(data);

    _docWithrawals.forEach((element) {
      if (element.docid == userId) {
        _dataWithdraw.add(element);
      }
    });

    _tempDocList.forEach((element) {
      if (element.docid == userId) {
        _dataWithdraw.add(element);
      }
    });

    var res = WithdrawList(
      withdraw: _dataWithdraw,
    );

    await FirebaseFirestore.instance
        .collection('DoctorWithdrawRequest')
        .doc(userId)
        .set(res.toMap());

    _dataWithdraw.add(data);

    var res1 = WithdrawList(
      withdraw: _dataWithdraw,
    );

    await FirebaseFirestore.instance
        .collection('DoctorWithdrawRequest')
        .doc(userId)
        .update(res1.toMap());

    notifyListeners();
  }

  clearWithdrawList() {
    _dataWithdraw.clear();
  }
}
