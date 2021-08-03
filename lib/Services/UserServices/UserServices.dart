import 'package:camhed/Model/AuthType.dart';
import 'package:camhed/Model/UserModel/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addUser(String userId, UserProfile user) {
    return _db.collection('UserProfile').doc(userId).set(user.toMap());
  }

  Future<UserProfile> fetchUser(String userId) {
    return _db
        .collection('UserProfile')
        .doc(userId)
        .get()
        .then((value) => UserProfile.fromFirestore(value.data()));
  }
}
