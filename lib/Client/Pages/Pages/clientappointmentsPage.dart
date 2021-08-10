import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';


class ClientAppointmentPage extends StatefulWidget {
  const ClientAppointmentPage({Key key}) : super(key: key);

  @override
  _ClientAppointmentPageState createState() => _ClientAppointmentPageState();
}

class _ClientAppointmentPageState extends State<ClientAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: FlutterTicketWidget(width: width,
                  height: height/3,
                  color: Colors.black12,
                  isCornerRounded: true,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 7,
                                  top: 7,
                                  right: 7,
                                  bottom: 5),
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
                                            "Dr. Aditya",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w600,
                                                fontSize:
                                                height / 55),
                                          ),
                                          SizedBox(
                                            height: height / 250,
                                          ),
                                          Text(
                                            "Covid-19",
                                            style: TextStyle(
                                                color:
                                                Colors.black38,
                                                fontSize:
                                                height / 65),
                                          ),
                                          SizedBox(
                                            height: height / 200,
                                          ),
                                          Text(
                                            "10:00 AM - 07:00 PM",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize:
                                                height / 65),
                                          ),
                                          SizedBox(
                                              height: height / 250),
                                          Row(
                                            children: [
                                              Text(
                                                "Time Status: ",
                                                style: TextStyle(
                                                    color:
                                                    Colors.black38,
                                                    fontSize:
                                                    height / 65),
                                              ),
                                              Text(
                                                "Pending",
                                                style: TextStyle(
                                                    color:
                                                    Colors.orangeAccent,
                                                    fontSize:
                                                    height / 65),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                  //  ////////////////////////////////////////
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Center(child: Divider()),
                            )

                          ],
                        ),
                      ),
                    ],

                  )
              ),
            )
          ],
        ),
      ),



      );
  }
}
