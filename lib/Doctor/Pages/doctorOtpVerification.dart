import 'package:camhed/Auth/firestore.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:camhed/Doctor/Pages/createDoctorProfile.dart';
import 'package:camhed/Doctor/Pages/doctorRegister.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/Doctor/Pages/doctorverifyStatus.dart';
import 'package:camhed/Model/AuthType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// ignore: must_be_immutable
class DoctorOtpVerification extends StatefulWidget {
  String phone;
  DoctorOtpVerification(this.phone);

  @override
  _DoctorOtpVerificationState createState() => _DoctorOtpVerificationState();
}

class _DoctorOtpVerificationState extends State<DoctorOtpVerification> {
  bool _loading = true;
  bool _loading2 = false;
  String code = " ";
  String verificationId;
  String _countDown;
  OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 1 * 60;
  bool resendOtp = false;

  @override
  void dispose() {
    _otpCountDown.cancelTimer();
    super.dispose();
  }

  void _startCountDown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        setState(() {
          resendOtp = true;
        });
      },
    );
  }

  submitOtp() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      // Sign the user in (or link) with the credential
      var userData = await auth.signInWithCredential(phoneAuthCredential);

      if (userData != null) {
        var existingUser =
            await FireStoreServices().fetchType(userData.user.uid);
        AuthType data = AuthType(
          phone: widget.phone,
          userId: userData.user.uid,
          type: 'doctor',
        );
        if (existingUser == null) {
          await FireStoreServices().setType(data);
        }
        if (existingUser != null && existingUser.type == 'doctor') {
          var res = await FirebaseFirestore.instance
              .collection('DoctorProfile')
              .doc(userData.user.uid)
              .get();

          if (res.data()['status'] == 'done' && res.data()['fees'] != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  // builder: (context) => DoctorVerifyStatus(),
                  builder: (context) => DoctorHomePage(),
                ));
          } else if (res.data()['status'] == 'done' &&
              res.data()['fees'] == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  // builder: (context) => DoctorVerifyStatus(),
                  builder: (context) => CreateDoctorProfile(),
                ));
          } else if (res.data()['status'] == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    // builder: (context) => DoctorVerifyStatus(),
                    builder: (context) => DoctorVerifyStatus()));
          } else if (res.data() == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorRegister(),
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
        } else {
          Fluttertoast.showToast(
              msg: "You Are Not A Doctor",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Wrong OTP",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        _loading2 = false;
      });
    }
  }

  verifyPhone() {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: "+91${widget.phone}",
      timeout: Duration(seconds: 120),
      verificationCompleted: (AuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
      },
      codeSent: (String verificationId, int resendToken) async {
        // Create a PhoneAuthCredential with the code
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // EasyLoading.init();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
    verifyPhone();
    _startCountDown();
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
              color: Color(0xffED1A4F),
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: height / 30,
                            width: height / 30,
                            decoration: BoxDecoration(
                                color: Color(0xffED1A4F),
                                borderRadius:
                                    BorderRadius.circular(height / 50)),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              size: height / 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "OTP Verification",
                              style: TextStyle(
                                  color: Color(0xffED1A4F),
                                  fontSize: height / 40,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: height / 2.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Images/Verified-bro.png"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child:
                        Text("Please check your mobile before enter otp code",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: height / 50,
                            )),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height / 60),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: Center(
                          child: OTPTextField(
                            onCompleted: (value) {
                              code = value;
                            },
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 30,
                            fieldStyle: FieldStyle.underline,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      height: height / 8.5,
                    ),
                  ),
                  SizedBox(
                    height: height / 55,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Seconds remaning :",
                        style: TextStyle(
                            color: Colors.black38, fontSize: height / 50),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Center(
                        child: Text(
                          _countDown,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: GestureDetector(
                      onTap: () {
                        if (code.length < 6) {
                          Fluttertoast.showToast(
                              msg: "Enter OTP",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM_RIGHT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          submitOtp();
                          setState(() {
                            _loading2 = true;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height / 80),
                            color: Color(0xffED1A4F)),
                        height: height / 12.5,
                        width: width,
                        child: Center(
                            child: _loading2
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "VALIDATE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: height / 45),
                                  )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 55,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive code ?",
                        style: TextStyle(color: Color(0xffED1A4F)),
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      (resendOtp)
                          ? InkWell(
                              onTap: () {
                                verifyPhone();
                                setState(() {
                                  resendOtp = false;
                                });
                                _startCountDown();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffED1A4F),
                                  borderRadius:
                                      BorderRadius.circular(height / 80),
                                ),
                                height: height / 20,
                                width: width / 4,
                                child: Center(
                                    child: Text(
                                  "Click here",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
