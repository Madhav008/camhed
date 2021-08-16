import 'package:camhed/Admin/AdminPages/addcity.dart';
import 'package:flutter/material.dart';

class AddCountry extends StatefulWidget {
  const AddCountry({Key key}) : super(key: key);

  @override
  _AddCountryState createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add Country",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "--- Added Countries ---",
                    style: TextStyle(
                        fontSize: height / 45, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCity()));
                      },
                      child: Padding(
                        padding:
                        const EdgeInsets.only(right: 15, top: 15, left: 15),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(height / 100),
                          child: Container(
                            height: height / 10,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(height / 100),
                            ),
                            child: Center(child: Text("Cameroon",style: TextStyle(color: Colors.black,fontSize: height/45),)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
              child: Divider(thickness: 1,color: Color(0xffe8364e),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "--- Added New Country ---",
                    style: TextStyle(
                        fontSize: height / 45, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Add New Country",
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
            ),
            Container(
              height: height / 18,
              width: width/3,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(height / 50)),
              child: Center(
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
