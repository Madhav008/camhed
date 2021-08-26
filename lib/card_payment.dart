import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CustomCardPaymentScreen extends StatefulWidget {
  const CustomCardPaymentScreen({Key key}) : super(key: key);

  @override
  _CustomCardPaymentScreenState createState() =>
      _CustomCardPaymentScreenState();
}

class _CustomCardPaymentScreenState extends State<CustomCardPaymentScreen> {
  Map<String, dynamic> paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            makePayment();
          },
          child: Text("Pay Ammount"),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse("https://stripe121.herokuapp.com/");

    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    paymentIntentData = json.decode(response.body);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['paymentIntent'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'US',
            merchantDisplayName: 'TechZirkon'));

    setState(() {});

    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
          clientSecret: paymentIntentData['paymentIntent'],
          confirmPayment: true,
        ),
      );
      setState(() {
        paymentIntentData = null;
      });

      Fluttertoast.showToast(msg: "Payment Done Succesfully");
    } catch (e) {
      print("Eroor");
      print(e);
    }
  }
}
