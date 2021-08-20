import 'package:camhed/Client/Pages/Pages/clienthomePage.dart';
import 'package:camhed/Client/Pages/Pages/loginPage.dart';
import 'package:camhed/Client/Pages/splashScreen/SplashScreen.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:camhed/Doctor/Pages/doctorRegister.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

          // print(userType);
          if (userType == "doctor") {
//Status Check Of Doctor Verification
            var res = await FirebaseFirestore.instance
                .collection('DoctorProfile')
                .doc(userId)
                .get();

            if (res.data() == null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => DoctorVerifyStatus(),
                    builder: (context) => DoctorRegister(),
                  ));
            }

            if (res.data()['status'] == 'done') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => DoctorVerifyStatus(),
                    builder: (context) => DoctorHomePage(),
                  ));
            } else {
              //Rejection Handle For Doctor Profile
              Fluttertoast.showToast(
                  msg: "Your Profile Is Rejected  ",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM_RIGHT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
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
