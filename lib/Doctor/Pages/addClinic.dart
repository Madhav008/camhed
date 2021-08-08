import 'package:camhed/Doctor/Pages/createclinic.dart';
import 'package:camhed/Doctor/Pages/searchHospital.dart';
import 'package:flutter/material.dart';

class AddClinic extends StatefulWidget {
  const AddClinic({Key key}) : super(key: key);

  @override
  _AddClinicState createState() => _AddClinicState();
}

class _AddClinicState extends State<AddClinic> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ADD CLINIC",style: TextStyle(color: Color(0xffe8364e)),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add clinic to your profile",style: TextStyle(fontSize: height/40,fontWeight: FontWeight.w600),),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: height/3,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Images/Medicine.png"),fit: BoxFit.contain
                    )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchHospital()));
                  },
                  child: Container(
                    height: height/12,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height/60),
                      color: Color(0xffe8364e)
                    ),
                    child: Center(child: Text("ADD VISITING / HOSPITAL",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: height/45),)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateClinic()));
              //     },
              //     child: Container(
              //       height: height/12,
              //       width: width,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(height/60),
              //           color: Color(0xffe8364e)
              //       ),
              //       child: Center(child: Text("ADD OWNED CLINIC",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: height/45),)),
              //     ),
              //   ),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
