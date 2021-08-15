import 'dart:io';

import 'package:camhed/Model/AuthType.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:camhed/Model/UserModel/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'changeSessions.dart';

class DoctorAccount extends StatefulWidget {
  const DoctorAccount({Key key}) : super(key: key);

  @override
  _DoctorAccountState createState() => _DoctorAccountState();
}

class _DoctorAccountState extends State<DoctorAccount> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DoctorProfileModel> getProfileData() async {
    await getPhone();
    DoctorProfileModel data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('DoctorProfile').doc(userId).get();
    data = DoctorProfileModel.fromFirestore(res.data());

    return data;
  }

  var storageRef = FirebaseStorage.instance;
  String postId = Uuid().v4();
  File file;
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

  String userId = FirebaseAuth.instance.currentUser.uid;
  String phone;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController feeController = TextEditingController();

  Future<AuthType> getPhone() async {
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await _db.collection('userType').doc(userId).get();

    phone = res.data()['phone'];
  }

  TimeOfDay initialTime = TimeOfDay.now();
  List<TimeOfDay> start_time = [];
  List<TimeOfDay> end_time = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xfff1f0f6),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Account",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xffe8364e),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: FutureBuilder<DoctorProfileModel>(
            future: getProfileData(),
            builder: (context, snapshot) {
              DoctorProfileModel userData = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height / 4.5,
                      width: width,
                      color: Color(0xffe8364e),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: (file != null)
                                ? Container(
                                    height: height / 10,
                                    width: height / 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: FileImage(file),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: height / 10,
                                    width: height / 10,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "Images/userlogo.png"),
                                            fit: BoxFit.cover)),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "${userData.name}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: height / 50),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                nameController.text = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.name}",
                                suffixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Mobile",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                phone = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.phone}",
                                suffixIcon: Icon(Icons.phone_android),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "E-mail",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                emailController.text = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.email}",
                                suffixIcon: Icon(Icons.mail),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Fee",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                feeController.text = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.fees} \$",
                                suffixIcon: Icon(Icons.money),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Experiance",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                expController.text = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.experiance}",
                                suffixIcon: Icon(Icons.timeline),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Position",
                            style: TextStyle(
                                color: Colors.black38, fontSize: height / 55),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize:
                                    height / 60, // This is not so important
                              ),
                              onChanged: (value) {
                                positionController.text = value;
                              },
                              decoration: InputDecoration(
                                // errorText: doctorRegisterValidation.address.error,
                                hintText: "${userData.position}",
                                suffixIcon: Icon(Icons.person_outline),
                                hintStyle: TextStyle(color: Colors.black38),
                                alignLabelWithHint: false,
                                helperText: "",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Your Selected Sessions",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeSessions(
                                                      )));
                                    },
                                    child: Text(
                                      "Change...",
                                      style: TextStyle(color: Colors.orange),
                                    ))
                              ],
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: userData.startTime.length,
                              itemBuilder: (context, index) {

                                var start_time = userData.startTime[index];
                                start_time =
                                    start_time.split("(")[1].split(")")[0];

                                var end_time = userData.endTime[index];
                                
                                end_time = end_time.split("(")[1].split(")")[0];
                                return InkWell(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material(
                                        elevation: 1,
                                        child: Container(
                                            height: height / 15,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        start_time,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                height / 50,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text("To"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text(
                                                          end_time.toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  height / 50,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ));
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () async {
                                if (nameController.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update({"name": nameController.text});
                                }
                                if (phone.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('userType')
                                      .doc(userId)
                                      .update({"phone": phone});
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update({"phone": phone});
                                }

                                if (emailController.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update({"email": emailController.text});
                                }

                                if (positionController.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update({
                                    "position": positionController.text
                                  });
                                }

                                if (feeController.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update({"fees": feeController.text});
                                }
                                if (expController.text.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('DoctorProfile')
                                      .doc(userId)
                                      .update(
                                          {"experiance": expController.text});
                                }
                                Fluttertoast.showToast(
                                    msg: "Profile Updated",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM_RIGHT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Container(
                                height: height / 13,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Color(0xffe8364e),
                                    borderRadius:
                                        BorderRadius.circular(height / 80)),
                                child: Center(
                                    child: Text(
                                  "UPDATE",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
