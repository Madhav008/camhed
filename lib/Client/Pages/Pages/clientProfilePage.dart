import 'package:flutter/material.dart';

class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({Key key}) : super(key: key);

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select City",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height/4,
              width: width,
              color: Color(0xffe8364e),
              child: Column(
                children: [
                  Container(

                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
