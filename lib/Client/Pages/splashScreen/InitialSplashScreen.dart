import 'package:camhed/Client/Pages/Pages/clienthomePage.dart';
import 'package:camhed/Client/Pages/Pages/loginPage.dart';
import 'package:camhed/Client/Pages/splashScreen/SplashScreen.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({Key key}) : super(key: key);

  @override
  _InitialSplashScreenState createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  var userType;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) async {
        if (user == null) {
          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        } else {
          var userId = FirebaseAuth.instance.currentUser.uid;

          await FirebaseFirestore.instance
              .collection('userType')
              .doc(userId)
              .get()
              .then((value) => userType = value.data()['type']);

          print(userType);
          if (userType == "doctor") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorVerify(),
                ));
          }
          if (userType == "user") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientHomePage(),
                ));
          }
        }
      });
    });

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("splashScreen"),
        color: Colors.white,
      ),
    );
  }
}
