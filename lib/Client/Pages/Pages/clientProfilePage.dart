import 'dart:io';

import 'package:camhed/Auth/firestore.dart';
import 'package:camhed/Model/AuthType.dart';
import 'package:camhed/Model/UserModel/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({Key key}) : super(key: key);

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserProfile> getProfileData() async {
    await getPhone();
    UserProfile data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('UserProfile').doc(userId).get();
    data = UserProfile.fromFirestore(res.data());

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
  TextEditingController addressController = TextEditingController();

  Future<AuthType> getPhone() async {
    var userId = FirebaseAuth.instance.currentUser.uid;

    var res = await _db.collection('userType').doc(userId).get();

    phone = res.data()['phone'];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<UserProfile>(
          future: getProfileData(),
          builder: (context, snapshot) {
            UserProfile userData = snapshot.data;
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
                          onTap: () {
                            handleChooseFromGallery().then((value) {
                              uploadImage(value).then((value) {
                                FirebaseFirestore.instance
                                    .collection('UserProfile')
                                    .doc(userId)
                                    .update({"profilePic": value});

                                Fluttertoast.showToast(
                                    msg: "Profile Picture Updated",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM_RIGHT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              });
                            });
                          },
                          child: (file != null)
                              ? Container(
                                  height: height / 10,
                                  width: height / 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: FileImage(file),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  height: height / 10,
                                  width: height / 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: (userData.profilePic != null)
                                              ? NetworkImage(
                                                  userData.profilePic)
                                              : NetworkImage(
                                                  'Images/userlogo.png'),
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
                              fontSize: height / 60, // This is not so important
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
                              fontSize: height / 60, // This is not so important
                            ),
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: phone,
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
                              fontSize: height / 60, // This is not so important
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
                          "Address",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            onChanged: (value) {
                              addressController.text = value;
                            },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "${userData.address}",
                              suffixIcon: Icon(Icons.home),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () async {
                              if (nameController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('UserProfile')
                                    .doc(userId)
                                    .update({"name": nameController.text});
                              }
                              if (phone.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('userType')
                                    .doc(userId)
                                    .update({"phone": phone});
                              }

                              if (emailController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('UserProfile')
                                    .doc(userId)
                                    .update({"email": emailController.text});
                              }

                              if (addressController.text.isNotEmpty) {
                                await FirebaseFirestore.instance
                                    .collection('UserProfile')
                                    .doc(userId)
                                    .update(
                                        {"address": addressController.text});
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
          }),
    );
  }
}
