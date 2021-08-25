import 'package:flutter/material.dart';

class DoctorWithdrawStatus extends StatefulWidget {
  String transacId, status;

  DoctorWithdrawStatus(this.transacId,this.status);

  @override
  _DoctorWithdrawStatusState createState() => _DoctorWithdrawStatusState();
}

class _DoctorWithdrawStatusState extends State<DoctorWithdrawStatus> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Withdraw Status",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (widget.status=="Pending")?Container(
              // height: height,
              child: Column(
                children: [
                  Container(
                    height: height/2,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Images/pending.png")
                      )
                    ),
                  ),
                  Text("Please wait at least 3 days for funds to transfer"),
                ],
              ),
            ):
            Container(
              child: Column(
                children: [
                  Container(
                    height: height/2,
                    width: width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Images/paymentdone.png")
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35,right: 35),
                    child: Text("You Payment has been completed (* it can take some time to deposit)"),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 50),
                    child: Material(
                      borderRadius: BorderRadius.circular(height/80),
                      elevation: 2,
                      child: Container(
                        height: height/12,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height/80)
                        ),
                        child: Center(child: Text("Transaction-id:  ${widget.transacId}",style: TextStyle(fontSize: height/45),)),
                      ),
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
