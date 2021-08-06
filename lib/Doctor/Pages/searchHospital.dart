import 'package:flutter/material.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({Key key}) : super(key: key);

  @override
  _SearchHospitalState createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
      TextField(
      style: new TextStyle(
      color: Colors.white,

      ),
      decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search,color: Colors.white),
          hintText: "Search...",
          hintStyle: new TextStyle(color: Colors.white)
      ),
    )
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),

      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

        ],
      ),
    );
  }
}
