import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:camhed/Doctor/Pages/addClinic.dart';
import 'package:camhed/Doctor/Pages/doctorverifyStatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDoctorProfile extends StatefulWidget {
  const CreateDoctorProfile({Key key}) : super(key: key);

  @override
  _CreateDoctorProfileState createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
  var _currentSelectedValue1;
  var _currentSelectedValue2;
  String name;
  String gender;
  String deg;
  String exp;
  bool isMale = false;
  @override
  void initState() {
    super.initState();
    var data = Provider.of<DoctorProfileProvider>(context, listen: false);
    data.getLocation();
    data.getSpeciality();
  }

  @override
  Widget build(BuildContext context) {
    var doctorProfileProvider = Provider.of<DoctorProfileProvider>(context);

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctor Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: InkWell(
                onTap: () async {
                  var userId = FirebaseAuth.instance.currentUser.uid;

                  if (name.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"name": name});
                  }

                  if (deg.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"position": deg});
                  }
                  if (_currentSelectedValue1.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"country": _currentSelectedValue1});
                  }
                  if (_currentSelectedValue2.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"category": _currentSelectedValue2});
                  }
                  if (gender.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"gender": gender});
                  }

                   if (exp.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"experiance": exp});
                  }
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddClinic()));
                },
                child: Text(
                  "SAVE",
                  style: TextStyle(
                      color: Color(0xffe8364e),
                      fontSize: height / 55,
                      fontWeight: FontWeight.w500),
                ),
              )),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(color: Colors.black38),
              ),
              TextFormField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        labelText: "Enter Your Country",
                      ),
                      isEmpty: _currentSelectedValue1 == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue1,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue1 = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items:
                              doctorProfileProvider.country.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Speciality',
                        labelText: "Enter Your Speciality",
                      ),
                      isEmpty: _currentSelectedValue2 == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue2,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue2 = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: doctorProfileProvider.specility
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Gender",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isMale,
                          onChanged: (value) {
                            // doctorRegisterValidation.setAgree();

                            setState(() {
                              isMale = !isMale;
                            });

                            if (isMale) {
                              gender = "Male";
                            }
                          },
                        ),
                        Text("Male")
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isMale == false ? true : false,
                            onChanged: (value) {
                              setState(() {
                                isMale = !isMale;
                              });
                              if (!isMale) {
                                gender = "Female";
                              }
                              // doctorRegisterValidation.setAgree();
                            },
                          ),
                          Text("Female")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Education",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  deg = value;
                },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Eg. MBBS",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Experience",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  exp = value;
                },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Years of experience",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
