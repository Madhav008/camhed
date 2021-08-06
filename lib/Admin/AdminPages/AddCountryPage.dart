import 'package:camhed/Admin/AdminModels/BannerModel.dart';
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
              // https://assets.mfine.co/api/contentservice/attachments/download/web/common/Homecare_small_web.jpg
              onPressed: () {
                HospitalModel data = new HospitalModel(
                    location: "Ellenabad,India", name: "Jain Hospital");
                AdminServices().addHospital(data);
              },
              child: Text("Add Hospital")),
          ElevatedButton(
              //
              onPressed: () {
                BannerModel data = new BannerModel(url: [
                  "https://assets.mfine.co/api/contentservice/attachments/download/web/common/Homecare_small_web.jpg",
                  "https://assets.mfine.co/api/contentservice/attachments/download/web/common/Homecare_small_web.jpg",
                  "https://assets.mfine.co/api/contentservice/attachments/download/web/common/Homecare_small_web.jpg"
                ]);
                AdminServices().addBanner(data);
              },
              child: Text("Add Banner")),
        ],
      ),
    );
  }
}
