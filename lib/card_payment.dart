import 'dart:convert';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: () async {
                var res = await BraintreeDropInRequest(
                  tokenizationKey: "sandbox_tvs84y3f_jvqyg4ywfjdvwv27",
                  collectDeviceData: true,
                  paypalRequest: BraintreePayPalRequest(
                      amount: '0.1', displayName: "Madhav"),
                  cardEnabled: true,
                );

                BraintreeDropInResult result = await BraintreeDropIn.start(res);
                http.post(Uri.tryParse(
                    'https://eb58-210-89-62-114.ngrok.io/?=payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'));
                if (result != null) {
                  print("Payment Done");
                  print(result.paymentMethodNonce.nonce);
                } else {
                  print("Payment Fail");
                }
              },
              child: Text("Pay"))
        ],
      ),
    );
  }
}
