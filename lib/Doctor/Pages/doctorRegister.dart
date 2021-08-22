import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/Model/DoctorModel/DoctorProfileModel.dart';
import 'package:camhed/Services/DoctorServices/DoctorServices.dart';
import 'package:camhed/validatior/Progress.aHUD.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({Key key}) : super(key: key);

  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  // bool value = false;
  var _currentSelectedValue1;
  List<String> cities = [];

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    var coordinates = Coordinates(position.latitude, position.longitude);
    var placemarks =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var placemark = placemarks[0];
    // String completeAddress =
    //     '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdminArea}, ${placemark.adminArea} ${placemark.postalCode}, ${placemark.countryName}';

    var locData = await FirebaseFirestore.instance
        .collection('Locations')
        .where('Country', isEqualTo: placemark.countryName)
        .get();

    locData.docs.forEach((location) {
      final loc = LocationModel.fromFirestore(location.data());
      var city = loc.city;

      setState(() {
        cities.addAll(city);
      });
    });
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var doctorRegisterValidation =
        Provider.of<DoctorRegisterValidation>(context);
    var doctorProfileProvider = Provider.of<LocationProvider>(context);
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

                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(),
                              ),
                              labelStyle: TextStyle(color: Colors.black38),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              labelText: "Enter Your City",
                            ),
                            isEmpty: _currentSelectedValue1 == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currentSelectedValue1,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                      _currentSelectedValue1 = newValue;
                                    state.didChange(newValue);
                                  });

                                  doctorRegisterValidation
                                      .changeAddress(newValue);
                                },
                                items: cities.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    )
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
                  doctorRegisterValidation.setApiCall();

                  var id = FirebaseAuth.instance.currentUser.uid;
                  if (doctorRegisterValidation.name.value != null &&
                      doctorRegisterValidation.email.value != null &&
                      doctorRegisterValidation.address.value != null &&
                      doctorRegisterValidation.agree != false) {
                    DoctorProfileModel data = DoctorProfileModel(
                      name: doctorRegisterValidation.name.value,
                      email: doctorRegisterValidation.email.value,
                      address: doctorRegisterValidation.address.value,
                      doctorId: id,
                    );

                    var userId = FirebaseAuth.instance.currentUser.uid;
                    DoctorServices().addUser(userId, data).then((value) {
                      doctorRegisterValidation.setApiCall();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorVerify()));
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Fill The Form Completly.  ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
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
