import 'package:camhed/Client/Pages/Pages/clienthomePage.dart';
import 'package:camhed/Client/Pages/Pages/loginPage.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:camhed/Client/Pages/splashScreen/SplashScreen.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:camhed/Doctor/Pages/addClinic.dart';
import 'package:camhed/Doctor/Pages/createDoctorProfile.dart';
import 'package:camhed/Doctor/Pages/doctorRegister.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/Doctor/Pages/doctorverifyStatus.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({Key key}) : super(key: key);

  @override
  _InitialSplashScreenState createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  var userType;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Future.delayed(Duration(seconds: 1), () {
      Provider.of<LocationProvider>(context, listen: false)
          .enableLocationServices();
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

            if (res.data()['status'] == 'done' && res.data()['fees'] == null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => DoctorVerifyStatus(),
                    builder: (context) => CreateDoctorProfile(),
                  ));
            } else if (res.data()['status'] == 'done' &&
                res.data()['fees'] != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => DoctorVerifyStatus(),
                    builder: (context) => DoctorHomePage(),
                  ));
            } else if (res.data()['status'] == null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      // builder: (context) => DoctorVerifyStatus(),
                      builder: (context) => DoctorVerifyStatus()));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffe8364e),
        toolbarHeight: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.elasticIn,
            child: Container(
              height: height/7,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Images/CAMHED.png")
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CircularProgressIndicator(
              color: Color(0xffe8364e),
            ),
          )
        ],
      ),
    );
  }
}
