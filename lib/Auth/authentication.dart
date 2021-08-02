import 'package:camhed/Auth/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  FireStoreServices _firestoreService = FireStoreServices();

  // Future<User> signUp(Users data, String password) async {
  //   User user;
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: data.email, password: password);

  //     var existingUser =
  //         await _firestoreService.fetchUser(userCredential.user.uid);

  //     var userData = Users(
  //         userId: userCredential.user.uid,
  //         name: data.name,
  //         phone: data.phone,
  //         email: data.email,
  //         isAdmin: false,
  //         image: data.image);

  //     if (existingUser == null) {
  //       await _firestoreService.addUser(userData);
  //     }
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(
  //           msg: "The password provided is too weak.  ",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(
  //           msg: "The account already exists for that email.  ",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return user;
  // }

  // ignore: missing_return
  // Future<User> signIn(String email, String password) async {
  //   User user;
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     user = userCredential.user;

  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       Fluttertoast.showToast(
  //           msg: "No user found for that email.  ",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       Fluttertoast.showToast(
  //           msg: "Wrong password provided for that user.  ",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
