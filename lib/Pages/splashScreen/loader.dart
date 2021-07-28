import 'package:camhed/Pages/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';


class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    var _alignment1 = Alignment.topCenter;
    var _alignment2 = Alignment.bottomCenter;
    Future.delayed(Duration(seconds: 2), () {
      // OneSignal.shared.init("c0069866-c963-42d5-9cda-f05f59b99886");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen1(),
          ));
    });
    return Scaffold(
      backgroundColor: Color(0xffed1a4f),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        AnimatedContainer(
                  duration: Duration(seconds: 2),
                  alignment: _alignment1,
                  child: Container(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _alignment1 = Alignment.center;
                          });
                        },
                          child: Image.asset('assets/Images/mafosup.png')))),
          AnimatedContainer(
              duration: Duration(seconds: 2),
              alignment: _alignment2,
              child: Container(
                  child: InkWell(
                      onTap: (){
                        setState(() {
                          _alignment1 = Alignment.center;
                        });
                      },
                      child: Image.asset('assets/Images/mafosdown.png')))),
        ],
      ),

      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     // mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       AnimatedContainer(
      //           duration: Duration(seconds: 2),
      //           alignment: _alignment,
      //           child: Container(
      //               child: InkWell(
      //                 onTap: (){
      //                   setState(() {
      //                     _alignment = Alignment.center;
      //                   });
      //                 },
      //                   child: Image.asset('assets/Images/mafosup.png')))),
      //       Container(child: Image.asset('assets/Images/mafosdown.png')),
      //     ],
      //   ),
      //   decoration: BoxDecoration(
      //     color: Color(0xffed1a4f)
      //   ),
      // ),
    );
  }
}