import 'package:camhed/validatior/validation_item.dart';
import 'package:flutter/cupertino.dart';

class UserRegisterValidation with ChangeNotifier {
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _address = ValidationItem(null, null);
  ValidationItem _name = ValidationItem(null, null);

  bool _isApiCallProcess = false;
  bool _agree = false;
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  //getter
  bool get agree => _agree;
  ValidationItem get email => _email;
  ValidationItem get name => _name;
  ValidationItem get address => _address;
  bool get isApiCallProcess => _isApiCallProcess;

  bool get isValid {
    if (_email != null && _address != null && _name != null && _agree == true) {
      return true;
    } else {
      return false;
    }
  }
  //setter

  void changeEmail(String value) {
    if (!_isValidEmail(value)) {
      _email = ValidationItem(null, "Please Enter Valid Email");
    } else {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeName(String value) {
    if (value.isEmpty) {
      _name = ValidationItem(null, "Please Enter Name");
    } else {
      _name = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeAddress(String value) {
    if (value.isEmpty) {
      _address = ValidationItem(null, "Please Enter Address");
    } else {
      _address = ValidationItem(value, null);
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
