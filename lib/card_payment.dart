import 'dart:convert';

import 'package:camhed/Auth/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
// import 'package:stripe_example/widgets/loading_button.dart';
import 'package:stripe_platform_interface/stripe_platform_interface.dart';

import '../config.dart';

class CustomCardPaymentScreen extends StatefulWidget {
  @override
  _CustomCardPaymentScreenState createState() =>
      _CustomCardPaymentScreenState();
}

class _CustomCardPaymentScreenState extends State<CustomCardPaymentScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 50),
            //   child: InkWell(
            //     onTap: (){
            //       FirebaseAuth.instance.currentUser.getIdToken().then((firebaseToken) async{
            //         var clientToken = await getBraintreeclientToken(firebaseToken);
            //         var res =  BraintreeDropInRequest(
            //           tokenizationKey: "sandbox_rzy6xqv2_dy65dghcpgb8dxq3",
            //           collectDeviceData: true,
            //           paypalRequest: BraintreePayPalRequest(
            //               amount: '100.00', displayName: "Madhav"),
            //           cardEnabled: true,
            //         );
            //         BraintreeDropInResult result = await BraintreeDropIn.start(res);
            //         var pri =50.00;
            //
            //         var data = await checkOut(firebaseToken,pri.toDouble(),result.paymentMethodNonce.toString());
            //
            //       });
            //
            //
            //     },
            //       child: Text("Pay")),
            // ),
            ElevatedButton(
                onPressed: () async {
                  var res =  BraintreeDropInRequest(
                    tokenizationKey: "sandbox_rzy6xqv2_dy65dghcpgb8dxq3",
                    collectDeviceData: true,
                    paypalRequest: BraintreePayPalRequest(
                        amount: '100.00', displayName: "Madhav"),
                    cardEnabled: true,
                  );

                  // BraintreeDropInResult result = await BraintreeDropIn.start(res);
                  // if(result != null){
                  //   print(result.paymentMethodNonce.description);
                  //   print(result.paymentMethodNonce.nonce);
                  // }


                  BraintreeDropInResult result = await BraintreeDropIn.start(res);

                  FirebaseAuth.instance.currentUser.getIdToken().then((firebaseToken) async {
                    var clientToken = await getBraintreeclientToken(
                        firebaseToken);
                    print(clientToken);
                    try{ var resresult = await http.post(Uri.tryParse(
                        'http://274b-169-149-255-124.ngrok.io/checkouts/'),
                      headers: <String, String>{
                        'Content-Type': 'application/json',
                        'accept':'application/json',
                        'Authorization':clientToken
                      },
                      body: jsonEncode(<String, String>{
                        'amount': "50.00",
                        'nonce':result.paymentMethodNonce.nonce,

                      }),


                    );
                    print(resresult.body);
                    }catch(e){
                      print("error");
                    }
                  },);


                  // if (result != null) {
                  //   print("Payment Done");
                  //   print(result.paymentMethodNonce.nonce);
                  // } else {
                  //   print("Payment Fail");
                  // }
                },
                child: Text("Pay")),
          ],
        ),
      ),
    );
  }
}
