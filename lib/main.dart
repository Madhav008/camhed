import 'package:camhed/Admin/AdminPages/AddCountryPage.dart';
import 'package:camhed/Client/Pages/Pages/clienthomePage.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:camhed/Doctor/Pages/addClinic.dart';
import 'package:camhed/Doctor/Pages/createDoctorProfile.dart';
import 'package:camhed/Doctor/Pages/doctorRegister.dart';
import 'package:camhed/Doctor/Pages/doctorverifyStatus.dart';
import 'package:camhed/validatior/doctorIdVaildation.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:camhed/validatior/userRegisterValidation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Client/Pages/Pages/doctorsListPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DoctorRegisterValidation(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRegisterValidation(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorIdValidation(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AddClinic(),
      ),
    );
  }
}
