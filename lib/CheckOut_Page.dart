import 'dart:convert';
import 'package:camhed/Client/Pages/Pages/clientappointmentsPage.dart';
import 'package:camhed/Client/Pages/Provider/AppointmentProvider.dart';
import 'package:camhed/Client/Pages/Provider/DoctorWalletProvider.dart';
import 'package:camhed/Client/Pages/splashScreen/InitialSplashScreen.dart';
import 'package:camhed/Model/AppointmentModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Model/DoctorModel/DoctorProfileModel.dart';

class CheckoutScreen extends StatefulWidget {
  final String sessionId;
  final DoctorProfileModel doctorProfileModel;
  final AppointmentModel data;
  const CheckoutScreen(
      {@required this.sessionId,
      @required this.doctorProfileModel,
      @required this.data});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  WebViewController _controller;

  String get initialUrl =>
      'data:text/html;base64,${base64Encode(Utf8Encoder().convert(stripeHtmlPage))}';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
      const stripe = Stripe("pk_test_51JSgLdSAU2VVzKqtLDriwc9t0a8MFrtT7j2L4wkQkG2NZNCC8RXgR7BEFnVpzP0oCSGpNyBMv51ukUvRXTT1WuS200p8r5ic9p");

      stripe.redirectToCheckout({
        sessionId: '$sessionId'
      }).then(function (result) {
        result.error.message = 'Error'
      });
    ''';

    try {
      await _controller.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var appointment = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Stripe Checkout')),
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController c) => _controller = c,
        onPageFinished: (String url) {
          if (url == initialUrl) {
            _redirectToStripe(widget.sessionId);
          }
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://example.com/success')) {
            print(request);

            appointment.setAppointment(
                widget.data, widget.doctorProfileModel.doctorId);

            appointment.getDoctorAppointmentsForUser(
                widget.doctorProfileModel.doctorId, widget.data);

            Provider.of<DoctorWalletProvider>(context, listen: false)
                .updateTotalAmount(int.parse(widget.doctorProfileModel.fees));

            return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ClientAppointmentPage(),
            ));
          } else if (request.url.startsWith('https://example.com/cancel')) {
            print(request);

            appointment.setAppointment(
                widget.data, widget.doctorProfileModel.doctorId);
            return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ClientAppointmentPage(),
            ));
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

const String stripeHtmlPage = '''
<!DOCTYPE html>
<html>
  <head>
    <title>Stripe checkout</title>
    <script src="https://js.stripe.com/v3/"></script>
    <style>
      body {
        min-height: 100vh;
        display: grid;
        align-items: center;
        text-align: center;
        font-size: 5rem;
      }      
    </style>
  </head>
  <body>
    <div>...Loading</div>
  </body>
</html>
''';
