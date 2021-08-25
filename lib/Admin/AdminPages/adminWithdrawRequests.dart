import 'package:camhed/Admin/AdminPages/AdminWithdrawDetails.dart';
import 'package:camhed/Admin/AdminProvider/AdminWalletProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminWithdrawRequests extends StatefulWidget {
  const AdminWithdrawRequests({Key key}) : super(key: key);

  @override
  _AdminWithdrawRequestsState createState() => _AdminWithdrawRequestsState();
}

class _AdminWithdrawRequestsState extends State<AdminWithdrawRequests> {
  @override
  void initState() {
    Provider.of<AdminWalletProvider>(context, listen: false)
        .getAllDocWithrawls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var allDocWithdrawals = Provider.of<AdminWalletProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Withdraw Requests",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "--- Withdraw Requests ---",
                    style: TextStyle(
                        fontSize: height / 45, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: allDocWithdrawals.docWithdrawls.length,
                  itemBuilder: (context, index) {
                    var docWithdrawls = allDocWithdrawals.docWithdrawls[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminWithdrawDetails(
                                  docWithdrawls.docid, docWithdrawls),
                            ));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(height / 80),
                          elevation: 2,
                          child: Container(
                            height: height / 12,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(height / 80)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(docWithdrawls.name),
                                  Text("\$ ${docWithdrawls.amount} "),
                                  Text("${docWithdrawls.withdrawId}")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
