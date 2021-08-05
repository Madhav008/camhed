import 'package:flutter/material.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({Key key}) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("COVID-19",style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.search),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),

      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15, top: 15,left: 15),
                      child: Material(
elevation: 1,
                        borderRadius: BorderRadius
                            .circular(height/100),
                        child: Container(
                          height: height / 4.3,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius:
                            BorderRadius
                                .circular(height/100),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7,top: 7,right: 7,bottom: 5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: height/12,
                                              width: height/12,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100000),
                                                image: DecorationImage(
                                                  image: AssetImage("Images/doctorlogo.png")
                                                )
                                              ),
                                            ),
                                            SizedBox(width: width/25,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Dr. Aditya Puri",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: height/55),),
                                                SizedBox(height: height/200,),
                                                Text("30+ Year Exp",style: TextStyle(color: Color(0xffe8364e),fontWeight: FontWeight.w500,fontSize: height/65),),
                                                SizedBox(height: height/250,),
                                                Text("MD (Medicine)",style: TextStyle(color: Colors.black38,fontSize: height/65),),
                                                SizedBox(height: height/250),
                                                Text("COVID-19",style: TextStyle(color: Colors.black38,fontSize: height/65),),
                                              ],
                                            )
                                          ],
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Icon(Icons.info_outline,color: Color(0xffe8364e),size: height/50,),
                                            Text("Appointment Fee",style: TextStyle(color: Colors.black38,fontSize: height/70),),
                                            Text("\$ 100",style: TextStyle(color: Color(0xffe8364e),fontWeight: FontWeight.w500,fontSize: height/40),)
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child: Container(
                                      height: height/25,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Color(0xffe8364e),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(child: Text("BOOK NOW ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),)),
                                    ),
                                  )

                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Sanjeevani The Medical Center",style: TextStyle(color: Colors.black87,fontSize: height/60),),
                                        SizedBox(height: height/100,),
                                        Text("Opposite Durga Mandir, Ratu Road Ranchi",style: TextStyle(color: Colors.black38,fontSize: height/60),),
                                      ],
                                    ),
                                    Container(
                                      height: height/20,
                                      width: height/20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100000),
                                          color: Color(0xffe8364e)
                                      ),
                                      child: Center(child: Icon(Icons.directions,color: Colors.white,)),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
