import 'package:camhed/Pages/splashScreen/splash_screen2.dart';
import 'package:flutter/material.dart';

class SplashScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
   body: Container(
     height: height,
     width: width,
     color: Colors.white,
     child: Stack(
       children: [
         Container(
           height: height,
           width: width,
           color: Colors.white,
         ),
         Align(
           alignment: Alignment.center,
           child: Padding(
             padding: const EdgeInsets.only(top: 80),
             child: Column(
               children: [
                 Container(
                   height: height/4,
                   width: height/4,
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage("assets/Images/popcorn 1.png")
                     )
                   ),
                 ),
                 SizedBox(height: height/100,),
                 Text("Choose a Tasty Dish",style: TextStyle(color: Colors.black,fontSize: 26),),
                 SizedBox(height: height/55,),
                 Text("Order anything you want from your",style: TextStyle(color: Colors.grey,fontSize: 17),),
                 SizedBox(height: height/150,),
                 Text("Favorite restaurant.",style: TextStyle(color: Colors.grey,fontSize: 17),),
                 SizedBox(height: height/8,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 12,
                       width: 12,

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Color(0xffed1a4f),
                       ),
                     ),
                     SizedBox(width: width/30,),
                     Container(
                       height: 12,
                       width: 12,

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.black12,
                       ),
                     ),
                     SizedBox(width: width/30,),
                     Container(
                       height: 12,
                       width: 12,

                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.black12,
                       ),
                     ),
                   ],
                 )
               ],
             ),
           ),
         ),
         Align(
           alignment: Alignment.bottomCenter,
           child: ClipPath(
             child: Container(
               height: height/4,
               decoration: BoxDecoration(
                 color: Color(0xffed1a4f),
                   // image: DecorationImage(
                   //     image: AssetImage("assets/Images/Frame 1.png"),fit: BoxFit.fill,
                   // )
               ),
             ),
             clipper: CustomClipperImage(),
           ),
         ),
         Align(
           alignment: Alignment.bottomRight,
           child: Padding(
             padding: const EdgeInsets.only(bottom: 55,right: 40),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 InkWell(
                   onTap: (){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SplashScreen2()));
                   },
                   child: Container(
                     height: height/17,
                     width: width/4.3,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(13)
                     ),
                     child: Center(child: Text("Next",style: TextStyle(fontSize: 17),)),
                   ),
                 ),
                 SizedBox(width: width/25,),
                 Text("Skip ",style: TextStyle(fontSize: 16),)
               ],
             ),
           ),
         )
       ],
     ),
   ),
    );
  }
}


class CustomClipperImage extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height/2.5);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.width);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}