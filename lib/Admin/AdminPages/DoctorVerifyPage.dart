import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';

class DoctorVerifyPage extends StatefulWidget {
  const DoctorVerifyPage({Key key}) : super(key: key);

  @override
  _DoctorVerifyPageState createState() => _DoctorVerifyPageState();
}

class _DoctorVerifyPageState extends State<DoctorVerifyPage> {
  @override
  Widget build(BuildContext context) {
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
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("Images/add.png"),
                            height: height / 6,
                          ),
                        ],
                      ),
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
                          borderRadius: BorderRadius.circular(height / 90),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("Images/add.png"),
                            height: height / 6,
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Text(
                            "Add back Side of Your ID",
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      ),
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
                          borderRadius: BorderRadius.circular(height / 90),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("Images/userphoto.png"),
                            height: height / 6,
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Text(
                            "Add your photo",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
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
                    Container(
                      height: height / 13,
                      width: width/2.5,
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
                    Container(
                      height: height / 13,
                      width: width/2.5,
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
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}
