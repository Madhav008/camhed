import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClinic extends StatefulWidget {
  const CreateClinic({Key key}) : super(key: key);

  @override
  _CreateClinicState createState() => _CreateClinicState();
}

class _CreateClinicState extends State<CreateClinic> {
  var _currentSelectedValue1;
  var _currentSelectedValue2;
  String name;
  String gender;
  String deg;
  String exp;
  bool isMale = false;

  TimeOfDay initialTime = TimeOfDay.now();

  List <TimeOfDay> start_time = [];
  List <TimeOfDay> end_time = [];

  @override
  Widget build(BuildContext context) {
    // var doctorProfileProvider = Provider.of<DoctorProfileProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Clinic",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: InkWell(
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
                "Clinic/Hospital Name",
                style: TextStyle(color: Colors.black38),
              ),
              TextFormField(
                // onChanged: (value) {
                //   name = value;
                // },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Enter your clinic Name",
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
                        labelText: "Enter Your Location",
                      ),
                      isEmpty: _currentSelectedValue1 == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue1,
                          isDense: true,
                          onChanged: (String newValue) {
                            // setState(() {
                            //   _currentSelectedValue1 = newValue;
                            //   state.didChange(newValue);
                            // });
                          },
                          // items: doctorProfileProvider.city.map((String value) {
                          //   return DropdownMenuItem<String>(
                          //     value: value,
                          //     child: Text(value),
                          //   );
                          // }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Clinic Number",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              TextFormField(
                // onChanged: (value) {
                //   deg = value;
                // },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Enter Clinic Number",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Fees",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  exp = value;
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
                            borderRadius: BorderRadius.circular(height/100)
                          ),
                          height: height/20,
                            width: width/4,
                            child: Center(child: Text("Start",style: TextStyle(color: Colors.white),)))),
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
                          print(end_time);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffe8364e),
                                  borderRadius: BorderRadius.circular(height/100)
                              ),
                              height: height/20,
                              width: width/4,
                              child: Center(child: Text("End",style: TextStyle(color: Colors.white),))),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Text("(*You can add multiple sessions)",style: TextStyle(color: Colors.black38,fontSize: height/70),),
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
                  itemCount: start_time.length ,
                  itemBuilder: (context, index) {
                    return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: height/15,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(start_time[index].hour.toString() +":"+ start_time[index].minute.toString(),style: TextStyle(color: Colors.black,fontSize: height/50,fontWeight: FontWeight.w600),),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(end_time[index].hour.toString() +":"+ end_time[index].minute.toString(),style: TextStyle(color: Colors.black38),),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
