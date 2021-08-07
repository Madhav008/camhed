import 'package:flutter/material.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({Key key}) : super(key: key);

  @override
  _SearchHospitalState createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textfieldDimension = height / 18;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: height / 18,
          child: TextField(
            style: TextStyle(
              fontSize: height / 50, // This is not so important
            ),
            decoration: new InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Color(0xffe8364e),
              ),
              hintText: 'Search....',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffe8364e), width: 2.0),
                borderRadius: BorderRadius.circular(0.0),
              ),
              contentPadding: EdgeInsets.only(
                  bottom: textfieldDimension / 2, // HERE THE IMPORTANT PART
                  left: 20),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(0.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),
      ),
      bottomNavigationBar: Container(
        height: height / 16,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Can't find your Hospital?",
              style: TextStyle(color: Colors.black38),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Add it here",
                style: TextStyle(
                    color: Color(0xffe8364e), fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height/18,
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Clinics matching your search",style: TextStyle(color: Colors.black54),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                            height: height/15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mcm Optical",style: TextStyle(color: Colors.black,fontSize: height/50,fontWeight: FontWeight.w600),),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text("9a Samulong Highway Sto. Nino,Marikina City",style: TextStyle(color: Colors.black38),),
                              )
                            ],
                          )),
                      ],
                    ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
