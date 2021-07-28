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
    Future.delayed(Duration(seconds: 1), () {
      // FirebaseAuth.instance.authStateChanges().listen((User user) async {
      //   if (user == null) {
      //     await Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => StartingPage(),
      //         ));
      //   } else {
      //    await Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MainPage(user),
      //         ));
      //   }
      // });
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
                      child: Image.asset('assets/mafosup.png')))),
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
                      child: Image.asset('assets/mafosdown.png')))),
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