import 'package:camhed/Client/Pages/Provider/LocationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSelectCity extends StatefulWidget {
  const UserSelectCity({Key key}) : super(key: key);

  @override
  _UserSelectCityState createState() => _UserSelectCityState();
}

class _UserSelectCityState extends State<UserSelectCity> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).getLocation();
  }

  int selectedcity = 0;
  @override
  Widget build(BuildContext context) {
    var location = Provider.of<LocationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Select City",
          style: TextStyle(color: Color(0xffe8364e)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: location.city.length,
              itemBuilder: (context, index) {
                var city = location.city[index];
                return InkWell(
                  onTap: () {
                    location.changeCity(location.city[index]);
                    setState(() {
                      selectedcity = index;
                    });
                  },
                  child: ListTile(
                    leading: (selectedcity == index)
                        ? Checkbox(
                            onChanged: (value) {
                              location.changeCity(location.city[index]);
                              setState(() {
                                selectedcity = index;
                              });
                            },
                            activeColor: Color(0xffe8364e),
                            value: true,
                          )
                        : Checkbox(
                            onChanged: (value) {
                              location.changeCity(location.city[index]);
                              setState(() {
                                selectedcity = index;
                              });
                            },
                            activeColor: Color(0xffe8364e),
                            value: false,
                          ),
                    title: Text("${city}"),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
