import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MakeAppoinmentPage extends StatefulWidget {
  const MakeAppoinmentPage({Key key}) : super(key: key);

  @override
  _MakeAppoinmentPageState createState() => _MakeAppoinmentPageState();
}

class AppointmentModel {
  String name;
  String phone;
  String time;
  String gender;
  String date;
  String age;
  String address;
  AppointmentModel(
      {this.name,
      this.phone,
      this.time,
      this.gender,
      this.date,
      this.age,
      this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'gender': gender,
      'time': time,
      'Date': date,
      'age': age,
      'address': address,
    };
  }

  factory AppointmentModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return AppointmentModel(
        gender: firestore['gender'],
        name: firestore['name'],
        phone: firestore['phone'],
        age: firestore['age'],
        date: firestore['date'],
        address: firestore['address'],
        time: firestore['time']);
  }
}

class _MakeAppoinmentPageState extends State<MakeAppoinmentPage> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AppointmentModel> makeAppointment(AppointmentModel data) {
    var id = Uuid().v1();
    return _db.collection("Appointments").doc(id).set(data.toMap());
  }

  String name;
  String phone;
  String time;
  String gender;
  String date;
  String age;
  String address;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dr. Aditya Puri",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: height / 55),
                                    ),
                                    SizedBox(
                                      height: height / 200,
                                    ),
                                    Text(
                                      "30+ Year Exp",
                                      style: TextStyle(
                                          color: Color(0xffe8364e),
                                          fontWeight: FontWeight.w500,
                                          fontSize: height / 65),
                                    ),
                                    SizedBox(
                                      height: height / 250,
                                    ),
                                    Text(
                                      "MD (Medicine)",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: height / 65),
                                    ),
                                    SizedBox(height: height / 250),
                                    Text(
                                      "COVID-19",
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
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                          child: Container(
                                        height: height / 9,
                                        width: width / 5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xffe8364e)),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                height / 60)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Mon"),
                                            Text(
                                              "26",
                                              style: TextStyle(
                                                  color: Color(0xffe8364e),
                                                  fontSize: height / 50,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text("Jul"),
                                          ],
                                        ),
                                      )),
                                    );
                                  })),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Select Appointment Date",
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
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                          child: Container(
                                        height: height / 20,
                                        width: width / 2.3,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Color(0xffe8364e)),
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                height / 80)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("10:00 AM - 07:00 PM"),
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
                                    // onChanged: (value) {
                                    //   name = value;
                                    // },
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
                                    // onChanged: (value) {
                                    //   name = value;
                                    // },
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
                                  value: false,
                                  // onChanged: (value) {
                                  //   userRegisterValidation.setAgree();
                                  // },
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(fontSize: height / 70),
                                ),
                                Checkbox(
                                  value: false,
                                  // onChanged: (value) {
                                  //   userRegisterValidation.setAgree();
                                  // },
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(fontSize: height / 70),
                                ),
                                Checkbox(
                                  value: false,
                                  // onChanged: (value) {
                                  //   userRegisterValidation.setAgree();
                                  // },
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
                                    // onChanged: (value) {
                                    //   name = value;
                                    // },
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
                                    // onChanged: (value) {
                                    //   name = value;
                                    // },
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
                                  color: Colors.white, fontSize: height / 50),
                            )),
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
    );
  }
}
