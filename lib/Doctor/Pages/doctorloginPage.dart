import 'package:camhed/Client/Pages/Pages/loginPage.dart';
import 'package:camhed/Doctor/Pages/doctorOtpVerification.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
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
                        "Doctor Sign In",
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
                            "Enter your phone number to proceed",
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
            Container(
              height: height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Images/Mobile_login.png"))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  CountryListPick(
                      appBar: AppBar(
                        backgroundColor: Colors.blue,
                        title: Text('Select Country'),
                      ),
                      theme: CountryTheme(
                        isShowFlag: true,
                        isShowTitle: false,
                        isShowCode: false,
                        isDownIcon: false,
                        showEnglishName: true,
                      ),
                      initialSelection: '+91',
                      onChanged: (CountryCode code) {
                        print(code.name);
                        print(code.code);
                        print(code.dialCode);
                        print(code.flagUri);
                      },
                      useUiOverlay: true,
                      useSafeArea: false
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () async {
                              final phone = _phoneController.text.trim();
                              if (phone.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please Fill The Phone Number  ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM_RIGHT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => OtpVerification(phone),
                                //   ),
                                // );
                              }
                            },
                            child: Icon(
                              Icons.send,
                              color: Color(0xffed1a4f),
                            )),
                        focusColor: Colors.black26,
                        hoverColor: Colors.green,
                        labelText: "Phone Number",
                        hintText: "10 Digit Number",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffed1a4f),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(height / 80),
                          borderSide: new BorderSide(color: Color(0xffed1a4f)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 30),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GestureDetector(
                onTap: () async {
                  final phone = _phoneController.text.trim();
                  if (phone.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Please Fill The Phone Number  ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorOtpVerification(phone),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height / 80),
                      color: Color(0xffED1A4F)),
                  height: height / 12.5,
                  width: width,
                  child: Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: height / 45),
                      )),
                ),
              ),
            ),
            SizedBox(height: height / 50),
            Text(
              "or",
              style: TextStyle(fontSize: height / 50),
            ),
            SizedBox(height: height / 50),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                "Login as a User",
                style: TextStyle(fontSize: 18, color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
