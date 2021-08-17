import 'package:flutter/material.dart';

class DoctorWithdrawPage extends StatefulWidget {
  const DoctorWithdrawPage({Key key}) : super(key: key);

  @override
  _DoctorWithdrawPageState createState() => _DoctorWithdrawPageState();
}

class _DoctorWithdrawPageState extends State<DoctorWithdrawPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Withdraw",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20,top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("570 USD",style: TextStyle(fontSize: height/45,fontWeight: FontWeight.w500),),
                      Text("Avilable",style: TextStyle(color: Colors.black38),)
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Amount",
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
                    decoration: InputDecoration(
                      labelText: "Full Name",
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
                    decoration: InputDecoration(
                      labelText: "Account Number",
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
                    decoration: InputDecoration(
                      labelText: "Re-enter Account Number",
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
                    decoration: InputDecoration(
                      labelText: "Enter Ifse Code",
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
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: height/15,
                      width: width/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height/100),
                        color: Color(0xffe8364e)
                      ),
                      child: Center(child: Text("Withdraw",style: TextStyle(color: Colors.white,fontSize: height/45,fontWeight: FontWeight.w600),)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
