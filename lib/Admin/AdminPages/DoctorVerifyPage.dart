import 'package:camhed/Admin/AdminProvider/DoctorStatusProvider.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:camhed/notificationservecies.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorVerifyPage extends StatefulWidget {
  DoctorProfileModel data;

  DoctorVerifyPage(this.data);

  @override
  _DoctorVerifyPageState createState() => _DoctorVerifyPageState();
}

class _DoctorVerifyPageState extends State<DoctorVerifyPage> {
  @override
  Widget build(BuildContext context) {
    var doctor = Provider.of<DoctorStatusProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Verify Requests",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Check Doctor Details",
                style: TextStyle(color: Colors.black, fontSize: height / 35),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: FDottedLine(
                color: Colors.black38,
                height: 100.0,
                width: 50,
                strokeWidth: 2.0,
                dottedLength: 10.0,
                space: 4.0,
                child: InkWell(
                  child: Container(
                    height: height / 4,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height / 90),
                        image: DecorationImage(
                            image: (widget.data.idurl1 != null)
                                ? NetworkImage(widget.data.idurl1)
                                : AssetImage("Images/add.png")),
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: FDottedLine(
                color: Colors.black38,
                height: 100.0,
                width: 50,
                strokeWidth: 2.0,
                dottedLength: 10.0,
                space: 4.0,
                child: InkWell(
                  child: Container(
                    height: height / 4,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (widget.data.idurl1 != null)
                                ? NetworkImage(widget.data.idurl1)
                                : AssetImage("Images/add.png")),
                        borderRadius: BorderRadius.circular(height / 90),
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: FDottedLine(
                color: Colors.black38,
                height: 100.0,
                width: 50,
                strokeWidth: 2.0,
                dottedLength: 10.0,
                space: 4.0,
                child: InkWell(
                  child: Container(
                    height: height / 4,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (widget.data.idurl1 != null)
                                ? NetworkImage(widget.data.profilepic)
                                : AssetImage("Images/add.png")),
                        borderRadius: BorderRadius.circular(height / 90),
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 35, left: 20, right: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      doctor.removeStatus(widget.data);

                      NotificationServices()
                          .sendDoctorStatusNotification(widget.data.doctorId);

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 13,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                          color: Color(0xffed1a4f),
                          borderRadius: BorderRadius.circular(height / 50)),
                      child: Center(
                          child: Text(
                        "Reject",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      doctor.changeStatus(widget.data);

                      NotificationServices()
                          .sendDoctorStatusNotification(widget.data.doctorId);

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 13,
                      width: width / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(height / 50)),
                      child: Center(
                          child: Text(
                        "Verify",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
