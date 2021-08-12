import 'package:camhed/Doctor/Pages/doctorSettingPage.dart';
import 'package:flutter/material.dart';

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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorSettingPage()));
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
              DoctorAppoinments(height,width),
              DoctorAppoinmentsHistory(height,width),
            ],
            controller: _tabController,
          ),
        ));
  }
}

class DoctorAppoinments extends StatefulWidget {
  var height;
  var width;
  DoctorAppoinments(this.height,this.width);



  @override
  _DoctorAppoinmentsState createState() => _DoctorAppoinmentsState();
}

class _DoctorAppoinmentsState extends State<DoctorAppoinments> {
  @override
  Widget build(BuildContext context) {
    var height = widget.height;
    var width = widget.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(widget.height / 80),
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
                                                          "Images/avatar.png"),fit: BoxFit.cover)),
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
                                                  "Madhav Jindal",
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
                                                  "76",
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
                                                  "Female",
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
                                                      "9:00 - 10:00",
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
                                              "Mon",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              "26",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height / 50,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              "Oct",
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
                                                    "Confirmed",
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
                                                      "id",
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
  }
}

class DoctorAppoinmentsHistory extends StatefulWidget {
  var height;
  var width;
  DoctorAppoinmentsHistory(this.height,this.width);

  @override
  _DoctorAppoinmentsHistoryState createState() => _DoctorAppoinmentsHistoryState();
}

class _DoctorAppoinmentsHistoryState extends State<DoctorAppoinmentsHistory> {
  @override
  Widget build(BuildContext context) {
    var height = widget.height;
    var width = widget.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(widget.height / 80),
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
                                                          "Images/avatar.png"),fit: BoxFit.cover)),
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
                                                  "Madhav Jindal",
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
                                                  "76",
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
                                                  "Female",
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
                                                      "9:00 - 10:00",
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
                                              "Mon",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              "26",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height / 50,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            Text(
                                              "Oct",
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
                                                    "Confirmed",
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
                                                      "id",
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
  }
}






