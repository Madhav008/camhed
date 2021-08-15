import 'dart:async';

import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocation/geolocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class LocationProvider with ChangeNotifier {
  List<String> _city = [];
  String _selectedCity = "";
  List<String> get city => _city;
  String get selectedCity => _selectedCity;

  resetStreams() {
    _city.clear();
  }

  enableLocationServices() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _selectedCity = _pref.getString('city');

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) async {
      var coordinates =
          Coordinates(result.location.latitude, result.location.longitude);
      var placemarks =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var placemark = placemarks[0];
      // String completeAddress =
      //     '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdminArea}, ${placemark.adminArea} ${placemark.postalCode}, ${placemark.countryName}';
      String formattedAddress =
          "${placemark.locality}, ${placemark.countryName} ";
      _selectedCity = placemark.locality;

      print(placemark.addressLine);
      notifyListeners();
    });
  }

  changeCity(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('city', _selectedCity.toString());
    print(value);
    _selectedCity = value;
    notifyListeners();
  }

  // Geolocation
  getLocation() async {
    enableLocationServices();
    resetStreams();
    String _country = 'India';
    var locData = await FirebaseFirestore.instance
        .collection('Locations')
        .where('Country', isEqualTo: _country)
        .get();
    locData.docs.forEach((location) {
      final loc = LocationModel.fromFirestore(location.data());
      var city = loc.city;

      _city.addAll(city);
    });
    notifyListeners();
  }
}
