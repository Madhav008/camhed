
import 'package:camhed/Auth/firestore.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DoctorRemaningDetails extends StatefulWidget {
  String hospitalId;
  DoctorRemaningDetails({this.hospitalId});
  @override
  _DoctorRemaningDetailsState createState() => _DoctorRemaningDetailsState();
}

class _DoctorRemaningDetailsState extends State<DoctorRemaningDetails> {
  TimeOfDay initialTime = TimeOfDay.now();
  String fees;
  List<TimeOfDay> start_time = [];
  List<TimeOfDay> end_time = [];
  List<String> docId = [FirebaseAuth.instance.currentUser.uid];

  @override
  Widget build(BuildContext context) {
    var doctorProfileProvider = Provider.of<DoctorProfileProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ADD CLINIC",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: InkWell(
                onTap: () async {
                  // print(widget.hospitalId);
                  try{
                  var userId = FirebaseAuth.instance.currentUser.uid;
                  FirebaseFirestore.instance
                      .collection('Hospitals')
                      .doc(widget.hospitalId)
                      .update({
                    'Doctors': List<dynamic>.from(docId.map((e) => e)),
                  });

                  if (fees.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({"fees": fees});
                  }

                  if (start_time.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({
                      "StartTime": List<dynamic>.from(
                          start_time.map((e) => e.toString())),
                    });
                  }

                  if (end_time.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('DoctorProfile')
                        .doc(userId)
                        .update({
                      "EndTime":
                          List<dynamic>.from(end_time.map((e) => e.toString()))
                    });
                  }}catch (e){
                    Fluttertoast.showToast(msg: e);
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorHomePage()));
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
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Fees",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fees = value;
                    },
                    decoration: InputDecoration(
                      // errorText: doctorRegisterValidation.address.error,
                      hintText: "Entet fee per session",
                      hintStyle: TextStyle(color: Colors.black38),
                      alignLabelWithHint: false,
                      helperText: "",
                      fillColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Add Appointment Sessions",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () async {
                              TimeOfDay pickedTime = await showTimePicker(
                                context: context,
                                initialTime: initialTime,
                                builder: (BuildContext context, Widget child) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                start_time.add(pickedTime);
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffe8364e),
                                    borderRadius:
                                        BorderRadius.circular(height / 100)),
                                height: height / 20,
                                width: width / 4,
                                child: Center(
                                    child: Text(
                                  "Start",
                                  style: TextStyle(color: Colors.white),
                                )))),
                        InkWell(
                            onTap: () async {
                              TimeOfDay pickedTime = await showTimePicker(
                                context: context,
                                initialTime: initialTime,
                                builder: (BuildContext context, Widget child) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                end_time.add(pickedTime);
                              });

                              print(start_time);
                              // print(end_time);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffe8364e),
                                      borderRadius:
                                          BorderRadius.circular(height / 100)),
                                  height: height / 20,
                                  width: width / 4,
                                  child: Center(
                                      child: Text(
                                    "End",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                Text(
                                  "(*You can add multiple sessions)",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: height / 70),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      "Your Selected Sessions",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: start_time.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: height / 15,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        start_time[index].hour.toString() +
                                            ":" +
                                            start_time[index].minute.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: height / 50,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          end_time[index].hour.toString() +
                                              ":" +
                                              end_time[index].minute.toString(),
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
