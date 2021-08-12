import 'package:flutter/cupertino.dart';
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
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height/4.5,
              width: width,
              color: Color(0xffe8364e),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height/10,
                    width: height/10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("Images/userlogo.png"),fit: BoxFit.cover
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text("Aditya Puri",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: height/50),),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: height / 55),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      style: TextStyle(
                        fontSize: height /
                            60, // This is not so important
                      ),
                      onChanged: (value) {
                        // name = value;
                      },
                      decoration: InputDecoration(
                        // errorText: doctorRegisterValidation.address.error,
                        hintText: "Your Name",
                        suffixIcon: Icon(Icons.person),
                        hintStyle:
                        TextStyle(color: Colors.black38),
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Mobile",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: height / 55),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      style: TextStyle(
                        fontSize: height /
                            60, // This is not so important
                      ),
                      onChanged: (value) {
                        // name = value;
                      },
                      decoration: InputDecoration(
                        // errorText: doctorRegisterValidation.address.error,
                        hintText: "Your Number",
                        suffixIcon: Icon(Icons.phone_android),
                        hintStyle:
                        TextStyle(color: Colors.black38),
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "E-mail",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: height / 55),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      style: TextStyle(
                        fontSize: height /
                            60, // This is not so important
                      ),
                      onChanged: (value) {
                        // name = value;
                      },
                      decoration: InputDecoration(
                        // errorText: doctorRegisterValidation.address.error,
                        hintText: "Your Email",
                        suffixIcon: Icon(Icons.mail),
                        hintStyle:
                        TextStyle(color: Colors.black38),
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Gender",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: height / 55),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      style: TextStyle(
                        fontSize: height /
                            60, // This is not so important
                      ),
                      onChanged: (value) {
                        // name = value;
                      },
                      decoration: InputDecoration(
                        // errorText: doctorRegisterValidation.address.error,
                        hintText: "Gender",
                        suffixIcon: Icon(Icons.person_pin_circle),
                        hintStyle:
                        TextStyle(color: Colors.black38),
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Address",
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: height / 55),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextField(
                      style: TextStyle(
                        fontSize: height /
                            60, // This is not so important
                      ),
                      onChanged: (value) {
                        // name = value;
                      },
                      decoration: InputDecoration(
                        // errorText: doctorRegisterValidation.address.error,
                        hintText: "Your Address",
                        suffixIcon: Icon(Icons.home),
                        hintStyle:
                        TextStyle(color: Colors.black38),
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: height/13,
                      width: width,
                      decoration: BoxDecoration(
                        color: Color(0xffe8364e),
                        borderRadius: BorderRadius.circular(height/80)
                      ),
                      child: Center(child: Text("UPDATE",style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
