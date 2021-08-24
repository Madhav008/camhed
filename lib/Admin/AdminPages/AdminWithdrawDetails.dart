import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminWithdrawDetails extends StatefulWidget {
  const AdminWithdrawDetails({Key key}) : super(key: key);

  @override
  _AdminWithdrawDetailsState createState() => _AdminWithdrawDetailsState();
}

class _AdminWithdrawDetailsState extends State<AdminWithdrawDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Withdraw Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(
          children: [
            Text("Doctor Details",style: TextStyle(color: Colors.black54,fontSize: height/45),),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Name :   ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
                      Text("Aditya Puri",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/45),)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text("Email :   ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
                        Text("Aditya@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/45),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text("Account Number :   ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
                        Text("124563256314",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/45),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Text("Withdraw Amount :   ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
                        Text("25 \$",style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/45),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: TextFormField(
                // controller: countryControlller,
                decoration: InputDecoration(
                  labelText: "Enter Transection Id",
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
            ),

            Container(
              height: height / 15,
              width: width / 2.5,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(height / 50)),
              child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
