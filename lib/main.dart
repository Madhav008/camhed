import 'package:camhed/Admin/AdminPages/DoctorVerifyPage.dart';
import 'package:camhed/Admin/AdminPages/adminHomePage.dart';
import 'package:camhed/Admin/AdminProvider/AdminWalletProvider.dart';
import 'package:camhed/Admin/AdminProvider/ContryProvider.dart';
import 'package:camhed/Admin/AdminProvider/DoctorStatusProvider.dart';
import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorSearchProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorWalletProvider.dart';
import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:camhed/Client/Pages/splashScreen/InitialSplashScreen.dart';
import 'package:camhed/Client/Pages/splashScreen/SplashScreen.dart';
import 'package:camhed/Doctor/DoctorProvider/DoctorProfileProvider.dart';
import 'package:camhed/Doctor/DoctorProvider/SearchHospitalProvider.dart';
import 'package:camhed/Doctor/DoctorProvider/TimeSessaionProvider.dart';
import 'package:camhed/Doctor/Pages/DoctorHomePage.dart';
import 'package:camhed/Doctor/Pages/doctorRegister.dart';
import 'package:camhed/Doctor/Pages/doctorVerify.dart';
import 'package:camhed/validatior/doctorIdVaildation.dart';
import 'package:camhed/validatior/doctorRegisterValidation.dart';
import 'package:camhed/validatior/userRegisterValidation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51JSgLdSAU2VVzKqtLDriwc9t0a8MFrtT7j2L4wkQkG2NZNCC8RXgR7BEFnVpzP0oCSGpNyBMv51ukUvRXTT1WuS200p8r5ic9p";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setAppId("5d44a640-c2bb-46bc-8ddf-85c9fe35af10");
    Future<String> _getPref() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('firstTime');
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
        ChangeNotifierProvider(
          create: (context) => TimeSessionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorStatusProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorWalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminWalletProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<String>(
          future: _getPref(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == 'true') {
              return InitialSplashScreen();
            } else {
              return SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
