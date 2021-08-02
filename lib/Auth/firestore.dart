import 'package:camhed/Model/AuthType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setType(AuthType user) {
    return _db.collection('userType').doc(user.userId).set(user.toMap());
  }

  Future<AuthType> updateType(AuthType user) {
    return _db.collection('userType').doc(user.userId).update({});
  }

  Future<AuthType> fetchType(String userId) {
    return _db
        .collection('userType')
        .doc(userId)
        .get()
        .then((value) => AuthType.fromFirestore(value.data()));
  }

  // Future<List<Posts>> fetchPosts(String userId) async {
  //   List<Posts> data;

  //   var querySnapshot =
  //       await _db.collection('user').doc(userId).collection('userPosts').get();

  //   data = (querySnapshot.docs)
  //       .map((e) => Posts.fromFirestore(e.data()))
  //       .toList();
  //   // querySnapshot.docs.forEach((element) {
  //   //   data = Posts.fromFirestore(element.data());
  //   // });

  //   return data;
  // }
}
