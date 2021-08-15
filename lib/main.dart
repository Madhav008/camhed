import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorSearchProvider.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:camhed/Client/Pages/splashScreen/InitialSplashScreen.dart';
import 'package:camhed/Client/Pages/splashScreen/SplashScreen.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:camhed/Doctor/DoctorProvider/SearchHospitalProvider.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:camhed/validatior/doctorIdVaildation.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:camhed/validatior/userRegisterValidation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;

    Future<bool> _getPref() async {
      prefs = await SharedPreferences.getInstance();
      return prefs.getBool('firstTime');
    }

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
        ChangeNotifierProvider(
          create: (context) => SearchDoctorHospitalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorSearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<bool>(
          future: _getPref(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case true:
                return SplashScreen();
                break;
              default:
                return InitialSplashScreen();
            }
          },
        ),
      ),
    );
  }
}
