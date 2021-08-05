import 'package:camhed/Client/Pages/Pages/doctorsListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key key}) : super(key: key);


  @override
  _ClientHomePageState createState() => _ClientHomePageState();

}

class _ClientHomePageState extends State<ClientHomePage> {

  @override

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8,),
            Text("Ranchi",style: TextStyle(color: Color(0xffe8364e)),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Icon(Icons.notifications_none),
          )
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),

      ),
      drawer: Drawer(
        child: Column(
          children: [

          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 10),
              child: Container(
                height: height / 8,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 18, top: 15),
                          child: ClipRRect(

                            child: Container(
                              height: height / 8.5,
                              width: width/1.3,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  image: DecorationImage(
                                    image: NetworkImage("https://assets.mfine.co/api/contentservice/attachments/download/web/common/Homecare_small_web.jpg"),fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                  BorderRadius
                                      .circular(8),
                                  ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25,left: 15),
              child: Row(
                children: [
                  Text("Find Doctor by speciality",style: TextStyle(color: Colors.black,fontSize: height/45,fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(height/120),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(height/120),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GridView.builder(
                        shrinkWrap: true, //just set this property
                      physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 3/3,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 20),
                        itemCount: 10,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorListPage()));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Image(image: AssetImage("Images/corona.png"),height: height/12,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text("COVID-19",style: TextStyle(color: Colors.black38),),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25,left: 15),
              child: Row(
                children: [
                  Text("Find Doctors in Top Hospitals",style: TextStyle(color: Colors.black,fontSize: height/45,fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 20),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GridView.builder(
                      shrinkWrap: true, //just set this property
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          childAspectRatio: 3/4.1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, index) {
                        return Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(height/120),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(height/120),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(height/120),

                              ),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Image(image: AssetImage("Images/hospital.png"),height: height/10,),
                                    ),
                                    Divider(),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Text(
                                            'Meenakshi',
                                              style: TextStyle(color: Colors.black38,fontSize: height/65),
                                            overflow: TextOverflow.visible,
                                            maxLines: 2,
                                            softWrap: true,
                                          ),
                                        )
                                        // Text("COVID-19 COVID-19 COVID-19 COVID-19",style: TextStyle(color: Colors.black38),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
