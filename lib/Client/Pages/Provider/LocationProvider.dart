import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class LocationProvider with ChangeNotifier {
  List<String> _city = [];
  String _selectedCity;
  static var seleceted;
  static var tempseleceted;
  String _country = "";
  String _tempcity;

  String get tempcity => _tempcity;

  List<String> get city => _city;
  String get selectedCity => _selectedCity;
  resetStreams() {
    _city.clear();
  }

  enableLocationServices() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _selectedCity = _pref.getString('city');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    var coordinates = Coordinates(position.latitude, position.longitude);

    var placemarks =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var placemark = placemarks[0];
    // String completeAddress =
    //     '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdminArea}, ${placemark.adminArea} ${placemark.postalCode}, ${placemark.countryName}';
    String formattedAddress =
        "${placemark.locality}, ${placemark.countryName} ";
    if (placemark.adminArea != null) {
      seleceted = placemark.adminArea;
      _selectedCity = placemark.adminArea;
    }
    _country = placemark.countryName;
    notifyListeners();
  }

  changeCity(String value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('city', _selectedCity.toString());
    // print(value);
    // _selectedCity = value;
    tempseleceted = value;
    // seleceted = value;
    _tempcity = value;
    notifyListeners();
  }

  // Geolocation
  getLocation() async {
    enableLocationServices();
    resetStreams();

    var locData = await FirebaseFirestore.instance
        .collection('Locations')
        .where('Country', isEqualTo: _country)
        .get();

    resetStreams();

    locData.docs.forEach((location) {
      final loc = LocationModel.fromFirestore(location.data());
      var city = loc.city;

      _city.addAll(city);
    });

    notifyListeners();
  }
}
