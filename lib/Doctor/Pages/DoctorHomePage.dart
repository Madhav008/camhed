import 'package:camhed/Auth/authentication.dart';
import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorWalletProvider.dart';
import 'package:camhed/Doctor/Pages/doctorSettingPage.dart';
import 'package:camhed/Doctor/Pages/doctorWalletPage.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:camhed/validatior/Progress.aHUD.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key key}) : super(key: key);

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Appoinments'),
    Tab(text: 'History'),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
    Provider.of<AppointmentProvider>(context, listen: false)
        .getDoctorAppointments();
  
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        initialIndex: 1, // default is 0
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              tabs: myTabs,
              indicatorColor: Colors.white,
              indicatorWeight: 3.0,
              controller: _tabController,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorSettingPage()));
                    },
                    child: Icon(Icons.settings)),
              )
            ],
            elevation: 0,
            title: Text(
              "CamHed",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xffe8364e),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: TabBarView(
            children: [
              DoctorAppoinments(height, width),
              DoctorAppoinmentsHistory(height, width),
            ],
            controller: _tabController,
          ),
        ));
  }
}

class DoctorAppoinments extends StatefulWidget {
  var height;
  var width;
  DoctorAppoinments(this.height, this.width);

  @override
  _DoctorAppoinmentsState createState() => _DoctorAppoinmentsState();
}

class _DoctorAppoinmentsState extends State<DoctorAppoinments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var docAppointment = Provider.of<AppointmentProvider>(context);
    var height = widget.height;
    var width = widget.width;
    return ProgressHUD(
      inAsyncCall: docAppointment.isApiCallProcess,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: docAppointment.doctorAppointmentPending.length,
                itemBuilder: (context, index) {
                  AppointmentModel docData =
                      docAppointment.doctorAppointmentPending[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(widget.height / 80),
                      child: Container(
                          width: width,
                          height: height / 3.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height / 80),
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
                                          left: 7, top: 1, right: 7, bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: height / 10,
                                                width: height / 10,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "Images/avatar.png"),
                                                        fit: BoxFit.cover)),
                                              ),
                                              SizedBox(
                                                width: width / 25,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${docData.name}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: height / 55),
                                                  ),
                                                  SizedBox(
                                                    height: height / 250,
                                                  ),
                                                  Text(
                                                    "${docData.age}",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: height / 65),
                                                  ),
                                                  SizedBox(
                                                    height: height / 200,
                                                  ),
                                                  Text(
                                                    "${docData.gender}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: height / 65),
                                                  ),
                                                  SizedBox(
                                                      height: height / 250),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${docData.time}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .orangeAccent,
                                                            fontSize:
                                                                height / 65,
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
                                            height: height / 20,
                                            width: width / 4,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "Images/new.png"))),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
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
                                              // Text(
                                              //   "${docData.date}",
                                              //   style: TextStyle(
                                              //     color: Colors.red,
                                              //   ),
                                              // ),
                                              Text(
                                                "${docData.date}",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: height / 50,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              // Text(
                                              //   "${docData.date}",
                                              //   style: TextStyle(
                                              //     color: Colors.black38,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Container(
                                              height: height / 15,
                                              width: 1,
                                              color: Colors.black38,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Booking Status: "),
                                                    Text(
                                                      "Confirmed",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orangeAccent,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Appointment Id: ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                      Text(
                                                        "${docData.appointmentId}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,fontSize: height/75),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Amount: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                height / 55),
                                                      ),
                                                      Text(
                                                        "\$ ${docData.payment}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                height / 55),
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
      ),
    );
  }
}

class DoctorAppoinmentsHistory extends StatefulWidget {
  var height;
  var width;
  DoctorAppoinmentsHistory(this.height, this.width);

  @override
  _DoctorAppoinmentsHistoryState createState() =>
      _DoctorAppoinmentsHistoryState();
}

class _DoctorAppoinmentsHistoryState extends State<DoctorAppoinmentsHistory> {
  @override
  Widget build(BuildContext context) {
    var docHistory = Provider.of<AppointmentProvider>(context);
    var height = widget.height;
    var width = widget.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: docHistory.doctorAppointmentHistory.length,
              itemBuilder: (context, index) {
                var docHistDetail = docHistory.doctorAppointmentHistory[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(widget.height / 80),
                    child: Container(
                        width: width,
                        height: height / 3.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height / 80),
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
                                        left: 7, top: 1, right: 7, bottom: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: height / 10,
                                              width: height / 10,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "Images/avatar.png"),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: width / 25,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${docHistDetail.name}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height / 55),
                                                ),
                                                SizedBox(
                                                  height: height / 250,
                                                ),
                                                Text(
                                                  "${docHistDetail.age}",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: height / 65),
                                                ),
                                                SizedBox(
                                                  height: height / 200,
                                                ),
                                                Text(
                                                  "${docHistDetail.gender}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: height / 65),
                                                ),
                                                SizedBox(height: height / 250),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${docHistDetail.time}",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orangeAccent,
                                                          fontSize: height / 65,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: height / 20,
                                          width: width / 4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "Images/done.png"))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1),
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
                                            // Text(
                                            //   "${docHistDetail.date}",
                                            //   style: TextStyle(
                                            //     color: Colors.red,
                                            //   ),
                                            // ),
                                            Text(
                                              "${docHistDetail.date}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: height / 50,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // Text(
                                            //   "${docHistDetail.date}",
                                            //   style: TextStyle(
                                            //     color: Colors.black38,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Container(
                                            height: height / 15,
                                            width: 1,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Booking Status: "),
                                                  Text(
                                                    "Confirmed",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.orangeAccent,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Appointment Id: ",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black38),
                                                    ),
                                                    Text(
                                                      "${docHistDetail.appointmentId}",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black38,fontSize: height/75),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Amount: ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              height / 55),
                                                    ),
                                                    Text(
                                                      "\$ ${docHistDetail.payment}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              height / 55),
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
  }
}
