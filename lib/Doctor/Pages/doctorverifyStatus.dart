import 'package:flutter/material.dart';

class DoctorVerifyStatus extends StatefulWidget {
  const DoctorVerifyStatus({Key key}) : super(key: key);

  @override
  _DoctorVerifyStatusState createState() => _DoctorVerifyStatusState();
}

class _DoctorVerifyStatusState extends State<DoctorVerifyStatus> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image(image: AssetImage("Images/verification.png"),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text("Your Documents Are Under Review",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold,fontSize: height/40),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Please Wait at least 24 hours",style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500,fontSize: height/50),),
            )
            ],
        ),
      ),
    );
  }
}
