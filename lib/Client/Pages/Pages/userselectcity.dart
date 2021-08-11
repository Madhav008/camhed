import 'package:flutter/material.dart';

class UserSelectCity extends StatefulWidget {
  const UserSelectCity({Key key}) : super(key: key);

  @override
  _UserSelectCityState createState() => _UserSelectCityState();
}

class _UserSelectCityState extends State<UserSelectCity> {
  int selectedcity =0;
  @override
  Widget build(BuildContext context) {
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
          itemCount: 5,
                itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  setState(() {
                    selectedcity = index;
                  });

                },
                child: ListTile(
                  leading: (selectedcity==index)?Checkbox(
                    onChanged: (value){
                      setState(() {
                        selectedcity = index;
                      });
                    },
                    activeColor: Color(0xffe8364e),
                    value: true,
                  ):Checkbox(
                    onChanged: (value){
                      setState(() {
                        selectedcity = index;
                      });
                    },
                    activeColor: Color(0xffe8364e),
                    value: false,
                  ),
                  title: Text("Ranchi"),
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
