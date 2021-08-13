import 'dart:math';

import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:camhed/validatior/Progress.aHUD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MakeAppoinmentPage extends StatefulWidget {
  DoctorProfileModel doctorProfileModel;
  String hospitalName;
  String hospitalLocation;

  MakeAppoinmentPage(
      {@required this.doctorProfileModel,
      @required this.hospitalLocation,
      @required this.hospitalName});

  @override
  _MakeAppoinmentPageState createState() => _MakeAppoinmentPageState();
}

class _MakeAppoinmentPageState extends State<MakeAppoinmentPage> {
  var userId = FirebaseAuth.instance.currentUser.uid;

  DateTime now = DateTime.now();

  String name;
  String phone;
  String time;
  String gender;
  String date;
  String age;
  String address;
  bool male = true;
  bool female = false;
  bool others = false;
  bool selectedDate = true;
  int selectedContainer;
  int selectedTimeContainer;
  String doctorId;
  @override
  void initState() {
    Provider.of<AppointmentProvider>(context, listen: false).getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appointment = Provider.of<AppointmentProvider>(context);
    DateTime dates = new DateTime(
      now.weekday,
      now.month,
      now.day,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Patient Details",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      body: ProgressHUD(
        // inAsyncCall: appointment.isApiCallProcess,
        inAsyncCall: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(height / 100),
                  child: Container(
                    height: height / 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(height / 100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 7, top: 7, right: 7, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: height / 12,
                                    width: height / 12,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100000),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "Images/doctorlogo.png"))),
                                  ),
                                  SizedBox(
                                    width: width / 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.doctorProfileModel.name}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: height / 55),
                                      ),
                                      SizedBox(
                                        height: height / 200,
                                      ),
                                      Text(
                                        "${widget.doctorProfileModel.experiance}+ Year Exp",
                                        style: TextStyle(
                                            color: Color(0xffe8364e),
                                            fontWeight: FontWeight.w500,
                                            fontSize: height / 65),
                                      ),
                                      SizedBox(
                                        height: height / 250,
                                      ),
                                      Text(
                                        "${widget.doctorProfileModel.position}",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 65),
                                      ),
                                      SizedBox(height: height / 250),
                                      Text(
                                        "${widget.doctorProfileModel.category}",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 65),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(height / 100),
                  child: Container(
                    height: height / 3.5,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(height / 100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select Appointment Date",
                            style: TextStyle(
                                fontSize: height / 45,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: height / 10,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      DateTime ndates =
                                          dates.add(Duration(days: index));
                                      String weekday =
                                          DateFormat('EEEE').format(ndates);
                                      String month =
                                          DateFormat('MMMM').format(ndates);
                                      // print(ndates);
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedContainer = index;
                                            });

                                            if (selectedContainer == index) {
                                              date = weekday.substring(0, 3) +
                                                  " " +
                                                  "${ndates.day}" +
                                                  " " +
                                                  month.substring(0, 3);
                                            }
                                            // print(date);
                                          },
                                          child: (selectedContainer == index)
                                              ? Container(
                                                  height: height / 9,
                                                  width: width / 5,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffe8364e)),
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              height / 60)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        weekday.substring(0, 3),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        ndates.day.toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height / 50,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        month.substring(0, 3),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  height: height / 9,
                                                  width: width / 5,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffe8364e)),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              height / 60)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        weekday.substring(0, 3),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        ndates.day.toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffe8364e),
                                                            fontSize:
                                                                height / 50,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        month.substring(0, 3),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ),
                                      );
                                    })),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Select Appointment Time",
                              style: TextStyle(
                                  fontSize: height / 45,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: height / 20,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                        .doctorProfileModel.startTime.length,
                                    itemBuilder: (context, index) {
                                      var startTime = widget
                                          .doctorProfileModel.startTime[index];
                                      startTime =
                                          startTime.split("(")[1].split(")")[0];

                                      var endTime = widget
                                          .doctorProfileModel.endTime[index];
                                      endTime =
                                          endTime.split("(")[1].split(")")[0];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedTimeContainer = index;
                                              });

                                              if (selectedTimeContainer ==
                                                  index) {
                                                time =
                                                    "${startTime}   -   ${endTime}";
                                              }
                                            },
                                            child: (selectedTimeContainer ==
                                                    index)
                                                ? Container(
                                                    height: height / 20,
                                                    width: width / 2.3,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Color(
                                                                0xffe8364e)),
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    height /
                                                                        80)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "${startTime}   -   ${endTime}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    height: height / 20,
                                                    width: width / 2.3,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Color(
                                                                0xffe8364e)),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    height /
                                                                        80)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "${startTime}   -   ${endTime}"),
                                                      ],
                                                    ),
                                                  )),
                                      );
                                    })),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(height / 100),
                  child: Container(
                    width: width,
                    height: height / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(height / 100),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Text(
                            "Patient",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: height / 50),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: width / 6,
                                  child: Row(
                                    children: [
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: height / 55),
                                      ),
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    height: height / 15,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: height /
                                            60, // This is not so important
                                      ),
                                      onChanged: (value) {
                                        name = value;
                                      },
                                      decoration: InputDecoration(
                                        // errorText: doctorRegisterValidation.address.error,
                                        hintText: "Your Name",
                                        hintStyle:
                                            TextStyle(color: Colors.black38),
                                        alignLabelWithHint: false,
                                        helperText: "",
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: width / 6,
                                  child: Row(
                                    children: [
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: height / 55),
                                      ),
                                      Text(
                                        "Age",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    height: height / 15,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: height /
                                            60, // This is not so important
                                      ),
                                      onChanged: (value) {
                                        age = value;
                                      },
                                      decoration: InputDecoration(
                                        // errorText: doctorRegisterValidation.address.error,
                                        hintText: "Age",
                                        hintStyle:
                                            TextStyle(color: Colors.black38),
                                        alignLabelWithHint: false,
                                        helperText: "",
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: width / 6,
                                  child: Row(
                                    children: [
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: height / 55),
                                      ),
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: Color(0xffe8364e),
                                    value: male,
                                    onChanged: (value) {
                                      setState(() {
                                        male = true;
                                        female = false;
                                        others = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Male",
                                    style: TextStyle(fontSize: height / 70),
                                  ),
                                  Checkbox(
                                    value: female,
                                    activeColor: Color(0xffe8364e),
                                    onChanged: (value) {
                                      setState(() {
                                        female = true;
                                        male = false;
                                        others = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(fontSize: height / 70),
                                  ),
                                  Checkbox(
                                    activeColor: Color(0xffe8364e),
                                    value: others,
                                    onChanged: (value) {
                                      setState(() {
                                        others = true;
                                        male = false;
                                        female = false;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Others",
                                    style: TextStyle(fontSize: height / 70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: width / 6,
                                  child: Row(
                                    children: [
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: height / 55),
                                      ),
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    height: height / 15,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: height /
                                            60, // This is not so important
                                      ),
                                      onChanged: (value) {
                                        address = value;
                                      },
                                      decoration: InputDecoration(
                                        // errorText: doctorRegisterValidation.address.error,
                                        hintText: "Address",
                                        hintStyle:
                                            TextStyle(color: Colors.black38),
                                        alignLabelWithHint: false,
                                        helperText: "",
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: width / 6,
                                  child: Row(
                                    children: [
                                      Text(
                                        "*",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: height / 55),
                                      ),
                                      Text(
                                        "Mobile",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: height / 55),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    height: height / 15,
                                    child: TextField(
                                      style: TextStyle(
                                        fontSize: height /
                                            60, // This is not so important
                                      ),
                                      onChanged: (value) {
                                        phone = value;
                                      },
                                      decoration: InputDecoration(
                                        // errorText: doctorRegisterValidation.address.error,
                                        hintText: "Mobile",
                                        hintStyle:
                                            TextStyle(color: Colors.black38),
                                        alignLabelWithHint: false,
                                        helperText: "",
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(height / 100),
                  child: Container(
                    height: height / 3.1,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(height / 100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Payment Details",
                            style: TextStyle(
                                fontSize: height / 45,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Appointment Fee",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: height / 55),
                                ),
                                Text(
                                  " \$${widget.doctorProfileModel.fees}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: height / 50),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Service Charge",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: height / 55),
                                ),
                                Text(
                                  " \$50",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: height / 50),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tax",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: height / 55),
                                ),
                                Text(
                                  " \$50",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: height / 50),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      color: Color(0xffe8364e),
                                      fontSize: height / 46,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  " \$50",
                                  style: TextStyle(
                                      color: Color(0xffe8364e),
                                      fontSize: height / 46,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {
                                var id = "camhead000" +
                                    Random().nextInt(999999).toString();
                                String gen;
                                if (male == true) {
                                  gen = "male";
                                } else if (female == true) {
                                  gen = "female";
                                } else {
                                  gen = "Other";
                                }
                                var data = AppointmentModel(
                                    appointmentId: id,
                                    doctorId:
                                        widget.doctorProfileModel.doctorId,
                                    userId: userId,
                                    name: name,
                                    age: age,
                                    gender: gen,
                                    address: address,
                                    phone: phone,
                                    date: date,
                                    time: time,
                                    bookingStatus: "Pending",
                                    doctorCategory:
                                        widget.doctorProfileModel.category,
                                    doctorName: widget.doctorProfileModel.name,
                                    hospitalName: widget.hospitalName,
                                    hospitalLocation: widget.hospitalLocation,
                                    paymentStatus: "fasle",
                                    payment: widget.doctorProfileModel.fees);

                                appointment.setAppointment(
                                    data, widget.doctorProfileModel.doctorId);
                              },
                              child: Container(
                                height: height / 18,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(height / 80),
                                    color: Color(0xffe8364e)),
                                child: Center(
                                    child: Text(
                                  "PAY NOW",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height / 50),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
