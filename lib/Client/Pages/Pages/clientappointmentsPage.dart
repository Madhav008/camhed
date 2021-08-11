import 'package:camhed/Model/AppointmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';

class ClientAppointmentPage extends StatefulWidget {
  const ClientAppointmentPage({Key key}) : super(key: key);

  @override
  _ClientAppointmentPageState createState() => _ClientAppointmentPageState();
}

class _ClientAppointmentPageState extends State<ClientAppointmentPage> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AppointmentList> getAppointments() async {
    AppointmentList data;
    var userId = FirebaseAuth.instance.currentUser.uid;
    var res = await _db.collection('Appointments').doc(userId).get();

    data = AppointmentList.fromFirestore(res.data());

    return data;

    // print(data.toMap());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      body: FutureBuilder<AppointmentList>(
          future: getAppointments(),
          builder: (context, snapshot) {
            List<AppointmentModel> appointments = snapshot.data.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        AppointmentModel data = appointments[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(height / 80),
                            child: Container(
                                width: width,
                                height: height / 3.7,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(height / 80),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 1, left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7,
                                                top: 1,
                                                right: 7,
                                                bottom: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: height / 10,
                                                      width: height / 10,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "Images/doctorlogo.png"))),
                                                    ),
                                                    SizedBox(
                                                      width: width / 25,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${data.doctorName}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  height / 55),
                                                        ),
                                                        SizedBox(
                                                          height: height / 250,
                                                        ),
                                                        Text(
                                                          "${data.doctorCategory}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize:
                                                                  height / 65),
                                                        ),
                                                        SizedBox(
                                                          height: height / 200,
                                                        ),
                                                        Text(
                                                          "${data.time}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  height / 65),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height / 250),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Time Status: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontSize:
                                                                      height /
                                                                          65),
                                                            ),
                                                            Text(
                                                              "${data.paymentStatus}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .orangeAccent,
                                                                  fontSize:
                                                                      height /
                                                                          65,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  height: height / 15,
                                                  width: width / 4,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "Images/unpaid.jpg"))),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            child: Center(child: Divider()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${data.date}",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${data.date}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: height / 50,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "${data.date}",
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Container(
                                                    height: height / 15,
                                                    width: 1,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Booking Status: "),
                                                          Text(
                                                            "${data.bookingStatus}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .orangeAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 3),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Appointment Id: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38),
                                                            ),
                                                            Text(
                                                              "${data.appointmentId}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black38),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Amount: ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      height /
                                                                          55),
                                                            ),
                                                            Text(
                                                              "\$ 55",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      height /
                                                                          55),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      })
                ],
              ),
            );
          }),
    );
  }
}
