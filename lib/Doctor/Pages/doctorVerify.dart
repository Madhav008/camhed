import 'dart:io';

import 'package:camhed/Doctor/Pages/addClinic.dart';
import 'package:camhed/Doctor/Pages/createDoctorProfile.dart';
import 'package:camhed/Doctor/Pages/doctorverifyStatus.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:camhed/Services/DoctorServices/DoctorServices.dart';
import 'package:camhed/notificationservecies.dart';
import 'package:camhed/validatior/Progress.aHUD.dart';
import 'package:camhed/validatior/doctorIdVaildation.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DoctorVerify extends StatefulWidget {
  const DoctorVerify({Key key}) : super(key: key);

  @override
  _DoctorVerifyState createState() => _DoctorVerifyState();
}

class _DoctorVerifyState extends State<DoctorVerify> {
  var storageRef = FirebaseStorage.instance;
  String postId = Uuid().v4();
  File file;
  File file1;
  File file2;
  File file3;

  Future<String> uploadImage(imageFile) async {
    var uploadTask = storageRef.ref("post_$postId.jpg").putFile(imageFile);
    var storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future handleChooseFromGallery() async {
    // ignore: deprecated_member_use
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // var file = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      this.file = File(file.path);
    });
    return this.file;
  }

  @override
  Widget build(BuildContext context) {
    var doctorIdValidation = Provider.of<DoctorIdValidation>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ProgressHUD(
        inAsyncCall: doctorIdValidation.isApiCallProcess,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    InkWell(
                      // onTap: () {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => StartingPage()));
                      // },
                      child: Container(
                        height: height / 30,
                        width: height / 30,
                        decoration: BoxDecoration(
                            color: Color(0xffED1A4F),
                            borderRadius: BorderRadius.circular(height / 50)),
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
                          "Verify details",
                          style: TextStyle(
                              color: Color(0xffED1A4F),
                              fontSize: height / 40,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height / 120,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 30,
                            ),
                            Text(
                              "Verify your Id/Documents Here",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: height / 55),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: height / 6,
                  width: width / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/user.png"),
                          fit: BoxFit.contain)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "We need to verify your ID",
                  style: TextStyle(color: Colors.black, fontSize: height / 35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: FDottedLine(
                  color: Colors.black38,
                  height: 100.0,
                  width: 50,
                  strokeWidth: 2.0,
                  dottedLength: 10.0,
                  space: 4.0,
                  child: InkWell(
                    onTap: () {
                      var userId = FirebaseAuth.instance.currentUser.uid;
                      handleChooseFromGallery().then((value) {
                        setState(() {
                          file1 = value;
                        });
                        uploadImage(value).then((value) {
                          FirebaseFirestore.instance
                              .collection('DoctorProfile')
                              .doc(userId)
                              .update({"idurl1": value});
                        });
                      });
                    },
                    child: Container(
                      height: height / 4,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height / 90),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (file1 != null)
                              ? Container(
                                  height: height / 4,
                                  width: width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(file1),
                                          fit: BoxFit.cover
                                      )),
                                )
                              : Image(
                                  image: AssetImage("Images/add.png"),
                                  height: height / 6,
                                ),
                          // (file1 == null)
                          //     ? SizedBox(
                          //         height: height / 80,
                          //       )
                          //     : SizedBox(
                          //         height: 0,
                          //       ),
                          // (file1 == null)
                          //     ? Text(
                          //         "Add front Side of Your ID",
                          //         style: TextStyle(color: Colors.black54),
                          //       )
                          //     : Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: FDottedLine(
                  color: Colors.black38,
                  height: 100.0,
                  width: 50,
                  strokeWidth: 2.0,
                  dottedLength: 10.0,
                  space: 4.0,
                  child: InkWell(
                    onTap: () {
                      var userId = FirebaseAuth.instance.currentUser.uid;
                      handleChooseFromGallery().then((value) {
                        setState(() {
                          file2 = value;
                        });
                        uploadImage(value).then((value) {
                          FirebaseFirestore.instance
                              .collection('DoctorProfile')
                              .doc(userId)
                              .update({"idBack": value});
                        });
                      });
                    },
                    child: Container(
                      height: height / 4,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height / 90),
                          color: Colors.white),
                      child: (file2 == null)?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Image(
                                  image: AssetImage("Images/add.png"),
                                  height: height / 6,
                                ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Text(
                            "Add back Side of Your ID",
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ):Container(
                        height: height / 4,
                        width: width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(file2),
                                fit: BoxFit.cover)),
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text("Add your photo",
                    style: TextStyle(
                        fontSize: height / 50, fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                child: FDottedLine(
                  color: Colors.black38,
                  height: 100.0,
                  width: 50,
                  strokeWidth: 2.0,
                  dottedLength: 10.0,
                  space: 4.0,
                  child: InkWell(
                    onTap: () {
                      var userId = FirebaseAuth.instance.currentUser.uid;
                      handleChooseFromGallery().then((value) {
                        setState(() {
                          file3 = value;
                        });
                        uploadImage(value).then((value) {
                          FirebaseFirestore.instance
                              .collection('DoctorProfile')
                              .doc(userId)
                              .update({"profilepic": value});
                        });
                      });
                    },
                    child: Container(
                      height: height / 4,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height / 90),
                          color: Colors.white),
                      child: (file3 == null)?Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Image(
                                  image: AssetImage("Images/userphoto.png"),
                                  height: height / 6,
                                ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Text(
                            "Add your photo",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ):Container(
                      height: height / 4,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(file3),
                              fit: BoxFit.cover)),
                    )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 15, right: 15, bottom: 30),
                child: InkWell(
                  onTap: () {
                    var userId = FirebaseAuth.instance.currentUser.uid;
                    OneSignal.shared.setExternalUserId(userId);
                    if (file1 != null &&
                        file2 != null &&
                        file3 != null &&
                        doctorIdValidation.isValid) {
                      doctorIdValidation.setApiCall();
                      NotificationServices().sendDoctorProfileNotification();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorVerifyStatus()));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Add Your Id's Properly  ",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM_RIGHT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                    height: height / 13,
                    width: width,
                    decoration: BoxDecoration(
                        color: Color(0xffed1a4f),
                        borderRadius: BorderRadius.circular(height / 50)),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
