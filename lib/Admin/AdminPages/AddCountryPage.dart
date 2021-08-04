import 'package:camhed/Admin/AdminModels/CategoryModel.dart';
import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Admin/AdminModels/LocationModel.dart';
import 'package:camhed/Admin/AdminServices/adminService.dart';
import 'package:flutter/material.dart';

class AddCountryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                LocationModel data = new LocationModel(name: "India");
                AdminServices().addCountry(data);
              },
              child: Text("Add Country")),
          ElevatedButton(
              onPressed: () {
                CategoryModel data = new CategoryModel(
                    categoryId: "25", name: "Covid Specialist");
                AdminServices().addCategory(data);
              },
              child: Text("Add Category")),
          ElevatedButton(
              onPressed: () {
                HospitalModel data = new HospitalModel(
                    location: "Ellenabad,India", name: "Jain Hospital");
                AdminServices().addHospital(data);
              },
              child: Text("Add Hospital")),
        ],
      ),
    );
  }
}
