import 'package:camhed/Model/AuthType.dart';
import 'package:camhed/Model/UserModel/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  bool addUser(String userId, UserProfile user) {
    try {
      _db.collection('UserProfile').doc(userId).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserProfile> fetchUser(String userId) {
    return _db
        .collection('UserProfile')
        .doc(userId)
        .get()
        .then((value) => UserProfile.fromFirestore(value.data()));
  }
}
