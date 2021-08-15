import 'package:camhed/Admin/AdminModels/HospitalModel.dart';
import 'package:camhed/Client/Pages/Provider/DoctorSearchProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key key}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var search = Provider.of<DoctorSearchProvider>(context, listen: false);
    search.resetStreams();
  }

  clearSearch() {
    var search = Provider.of<DoctorSearchProvider>(context, listen: false);
    searchController.clear();
    search.resetStreams();
    setState(() {});
  }

  bool show = true;
  @override
  Widget build(BuildContext context) {
    var _db = FirebaseFirestore.instance;

    var search = Provider.of<DoctorSearchProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Colors.black38,
                      decoration: InputDecoration(
                        hintText: "Search doctor here",
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xffED1A4F), width: 0.0),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (searchController.text.isNotEmpty) {
                              search.getDoctors(searchController.text);
                            }
                            clearSearch();
                          },
                          child: InkWell(
                            child: Icon(
                              Icons.navigate_next,
                              size: height / 25,
                              color: Color(0xffED1A4F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (search.doctor.length == 0)
                ? Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: height / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("Images/doctor.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                        Text(
                          "Search Doctors",
                          style: TextStyle(
                              color: Color(0xffED1A4F),
                              fontSize: height / 35,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: search.doctor.length,
                        itemBuilder: (context, index) {
                          var doc = search.doctor[index];
                          var hos = search.hospital[index];
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, top: 15, left: 15),
                              child: Material(
                                elevation: 1,
                                borderRadius:
                                    BorderRadius.circular(height / 100),
                                child: Container(
                                  height: height / 4.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius:
                                        BorderRadius.circular(height / 100),
                                  ),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7,
                                                top: 7,
                                                right: 7,
                                                bottom: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: height / 12,
                                                      width: height / 12,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100000),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "Images/doctorlogo.png"))),
                                                    ),
                                                    SizedBox(
                                                      width: width / 25,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${doc.name}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  height / 55),
                                                        ),
                                                        SizedBox(
                                                          height: height / 200,
                                                        ),
                                                        Text(
                                                          "${doc.experiance}",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffe8364e),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  height / 65),
                                                        ),
                                                        SizedBox(
                                                          height: height / 250,
                                                        ),
                                                        Text(
                                                          "${doc.position}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize:
                                                                  height / 65),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height / 250),
                                                        Text(
                                                          "${doc.category}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize:
                                                                  height / 65),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.info_outline,
                                                      color: Color(0xffe8364e),
                                                      size: height / 50,
                                                    ),
                                                    Text(
                                                      "Appointment Fee",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize:
                                                              height / 70),
                                                    ),
                                                    Text(
                                                      "${doc.fees}",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffe8364e),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              height / 40),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: InkWell(
                                              // onTap: () {
                                              // Navigator.push(
                                              // context,
                                              // MaterialPageRoute(
                                              // builder: (context) =>
                                              // MakeAppoinmentPage(
                                              // hospitalLocation:
                                             // hospitalData
                                              //     .location,
                                              // hospitalName:
                                              // hospitalData
                                              //     .name,
                                              // doctorProfileModel:
                                              // doctors[
                                              // index])));
                                              // },
                                              child: Container(
                                                height: height / 25,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffe8364e),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                    child: Text(
                                                  "BOOK NOW ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${hos.name}",
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: height / 60),
                                                ),
                                                SizedBox(
                                                  height: height / 100,
                                                ),
                                                Text(
                                                  "${hos.location}",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: height / 60),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: height / 20,
                                              width: height / 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100000),
                                                  color: Color(0xffe8364e)),
                                              child: Center(
                                                  child: Icon(
                                                Icons.directions,
                                                color: Colors.white,
                                              )),
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
                  )
          ],
        ),
      ),
    );
  }
}
