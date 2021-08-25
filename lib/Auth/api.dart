import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
final mainUrl ="http://274b-169-149-255-124.ngrok.io";
final braintreePath = "checkouts/";
final braintreePathr = "/checkouts/new";

Future<String> getBraintreeclientToken(token)async
{
  final response = await http.get(Uri.tryParse('$mainUrl$braintreePathr'),
  headers: {
    'Authorization':'Bearer $token'
  }
  );
  return response.body;
}

checkOut(String key,double amount,String nonce)async{
  var body={
    'amount':amount.toString(),
    'nonce':nonce
  };

  var res = await http.post(Uri.tryParse('$mainUrl$braintreePath'),
    headers: {
    "content-type":"application/json",
      "accept":"application/json",
      "Authorization":"Bearer $key"
    },body: json.encode(body));
  return res.statusCode==200 ?true:false;
}