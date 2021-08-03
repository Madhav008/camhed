import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/validatior/Progress.aHUD.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({Key key}) : super(key: key);

  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  // bool value = false;

  @override
  Widget build(BuildContext context) {
    var doctorRegisterValidation =
        Provider.of<DoctorRegisterValidation>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ProgressHUD(
        inAsyncCall: doctorRegisterValidation.isApiCallProcess,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Row(
                  children: [
                    InkWell(
                      // onTap: () {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => StartingPage()));
                      // },
                      child: Container(
                        height: height / 30,
                        width: height / 30,
                        decoration: BoxDecoration(
                            color: Color(0xffED1A4F),
                            borderRadius: BorderRadius.circular(height / 50)),
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          size: height / 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Doctor Register",
                          style: TextStyle(
                              color: Color(0xffED1A4F),
                              fontSize: height / 40,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height / 120,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 30,
                            ),
                            Text(
                              "Enter your details here",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: height / 55),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Doctor Register",
                  style: TextStyle(color: Colors.black, fontSize: height / 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        doctorRegisterValidation.changeName(value);
                      },
                      decoration: InputDecoration(
                        errorText: doctorRegisterValidation.name.error,
                        labelText: "Name",
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),

                    TextFormField(
                      onChanged: (value) {
                        doctorRegisterValidation.changeEmail(value);
                      },
                      decoration: InputDecoration(
                        errorText: doctorRegisterValidation.email.error,
                        labelText: "Email",
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),

                    TextFormField(
                      onChanged: (value) {
                        doctorRegisterValidation.changeAddress(value);
                      },
                      decoration: InputDecoration(
                        errorText: doctorRegisterValidation.address.error,
                        labelText: "Address",
                        alignLabelWithHint: false,
                        helperText: "",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),

                    // TextFormField(
                    //   onChanged: (value) {
                    //     // signInValidator.changeEmail(value);
                    //   },
                    //   decoration: InputDecoration(
                    //     // errorText: signInValidator.email.error,
                    //     labelText: "Referral Code (optional)",
                    //     alignLabelWithHint: false,
                    //     helperText: "",
                    //     fillColor: Colors.white,
                    //     border: new OutlineInputBorder(
                    //       borderRadius: new BorderRadius.circular(25.0),
                    //       borderSide: new BorderSide(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: doctorRegisterValidation.agree,
                      onChanged: (value) {
                        doctorRegisterValidation.setAgree();
                      },
                    ),
                    SizedBox(
                      width: width / 25,
                    ),
                    Expanded(
                        child: Text(
                      "I agree to Terms & Conditions and to CamHed use of my information in accordance with its privacy policy.",
                      style: TextStyle(
                          color: Colors.black38, fontSize: height / 50),
                    ))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DoctorVerify()));
                },
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Container(
                      height: height / 13,
                      width: width,
                      decoration: BoxDecoration(
                          color: Color(0xffed1a4f),
                          borderRadius: BorderRadius.circular(height / 50)),
                      child: Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
