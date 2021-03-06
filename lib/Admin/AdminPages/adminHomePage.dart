import 'package:camhed/Admin/AdminPages/DoctorVerifyPage.dart';
import 'package:camhed/Admin/AdminPages/adminSettings.dart';
import 'package:camhed/Admin/AdminProvider/ContryProvider.dart';
import 'package:camhed/Admin/AdminProvider/DoctorStatusProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false).getLocationData();
    OneSignal.shared.sendTag("Admin", "admin");
    
    Provider.of<DoctorStatusProvider>(context, listen: false).getDoctorData();
  }

  @override
  Widget build(BuildContext context) {
    var doctor = Provider.of<DoctorStatusProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Admin - Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminSettings()));
                },
                child: Icon(Icons.settings)),
          )
        ],
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "--- Verifications Requests ---",
                    style: TextStyle(
                        fontSize: height / 45, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: doctor.doctorData.length,
                  itemBuilder: (context, index) {
                    var doc = doctor.doctorData[index];
                    return InkWell(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 15, top: 15, left: 15),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(height / 100),
                          child: Container(
                            height: height / 8.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(height / 100),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, top: 7, right: 7, bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: height / 12,
                                                width: height / 12,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100000),
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
                                                    "${doc.name}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: height / 55),
                                                  ),
                                                  SizedBox(
                                                    height: height / 200,
                                                  ),
                                                  Text(
                                                    "${doc.phone}",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffe8364e),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: height / 65),
                                                  ),
                                                  SizedBox(
                                                    height: height / 250,
                                                  ),
                                                  Text(
                                                    "${doc.email}",
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: height / 65),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // doctor.changeStatus(doc);

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DoctorVerifyPage(
                                                                    doc)));
                                                  },
                                                  child: Container(
                                                      height: height / 20,
                                                      width: width / 4.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      height /
                                                                          120),
                                                          color: Color(
                                                              0xffe8364e)),
                                                      child: Center(
                                                          child: Text(
                                                        "Check",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                height / 55),
                                                      ))),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
