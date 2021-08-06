import 'package:camhed/validatior/validation_item.dart';
import 'package:flutter/cupertino.dart';

class DoctorIdValidation with ChangeNotifier {
  ValidationItem _frontId = ValidationItem(null, null);
  ValidationItem _backId = ValidationItem(null, null);
  ValidationItem _picture = ValidationItem(null, null);

  bool _isApiCallProcess = false;
  bool _agree = false;

  //getter
  ValidationItem get frontId => _frontId;
  ValidationItem get backId => _backId;
  ValidationItem get picture => _picture;
  bool get isApiCallProcess => _isApiCallProcess;

  bool get isValid {
    if (_frontId != null && _backId != null && _picture != null) {
      return true;
    } else {
      return false;
    }
  }
  //setter

  void changefrontId(String value) {
    if (value.isEmpty) {
      _frontId = ValidationItem(null, "Please Enter Valid Email");
    } else {
      _frontId = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeName(String value) {
    if (value.isEmpty) {
      _backId = ValidationItem(null, "Please Enter Name");
    } else {
      _backId = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeAddress(String value) {
    if (value.isEmpty) {
      _picture = ValidationItem(null, "Please Enter Address");
    } else {
      _picture = ValidationItem(value, null);
    }
    notifyListeners();
  }
  // void changePassword(String value) {
  //   if (value.length >= 6) {
  //     _password = ValidationItem(value, null);
  //   } else {
  //     _password =
  //         ValidationItem(null, "Please Enter at least 6 character password");
  //   }

  //   notifyListeners();
  // }
  void setAgree() {
    _agree = !_agree;
    notifyListeners();
  }

  void setApiCall() {
    _isApiCallProcess = !_isApiCallProcess;
    notifyListeners();
  }
}
