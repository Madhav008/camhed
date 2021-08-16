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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.settings),
          )
        ],
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),

    );
  }
}
