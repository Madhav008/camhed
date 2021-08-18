import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorWalletProvider.dart';
import 'package:camhed/Doctor/Pages/doctorWithdrawPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DoctorWalletPage extends StatefulWidget {
  const DoctorWalletPage({Key key}) : super(key: key);

  @override
  _DoctorWalletPageState createState() => _DoctorWalletPageState();
}

class _DoctorWalletPageState extends State<DoctorWalletPage> {
  @override
  void initState() {
    // print("DoctorWalletPage");
    Provider.of<DoctorWalletProvider>(context, listen: false).getTotalAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wallet = Provider.of<DoctorWalletProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height / 4.5,
              width: width,
              decoration: BoxDecoration(color: Color(0xffe8364e)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${wallet.amount} USD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: height / 30,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "Avilable Balance",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 23, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (wallet.amount > 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorWithdrawPage()));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Don't Have Enough Money To Withdraw",
                                    backgroundColor: Colors.red,
                                    fontSize: 15,
                                    textColor: Colors.white);
                              }
                            },
                            child: Container(
                              height: height / 20,
                              width: width / 4,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(height / 100),
                                  color: Colors.white),
                              child: Center(
                                  child: Text(
                                "Withdraw",
                                style: TextStyle(
                                    color: Color(0xffe8364e),
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "History",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: height / 35),
              ),
            )
          ],
        ),
      ),
    );
  }
}
