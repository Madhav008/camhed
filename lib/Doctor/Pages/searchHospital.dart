import 'package:camhed/Doctor/DoctorProvider/SearchHospitalProvider.dart';
import 'package:camhed/Doctor/Pages/createclinic.dart';
import 'package:camhed/Doctor/Pages/doctorRemaningdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({Key key}) : super(key: key);

  @override
  _SearchHospitalState createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var search =
        Provider.of<SearchDoctorHospitalProvider>(context, listen: false);
    search.resetStreams();
  }

  clearSearch() {
    var search =
        Provider.of<SearchDoctorHospitalProvider>(context, listen: false);
    searchController.clear();
    search.resetStreams();
    setState(() {});
  }

  bool issearch = false;

  @override
  Widget build(BuildContext context) {
    var search = Provider.of<SearchDoctorHospitalProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textfieldDimension = height / 18;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: height / 18,
          child: TextField(
            controller: searchController,
            style: TextStyle(
              fontSize: height / 50, // This is not so important
            ),
            decoration: new InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  if (searchController.text.isNotEmpty) {
                    search.getHospital(searchController.text);
                  }
                  clearSearch();
                },
                child: Icon(
                  Icons.search,
                  size: height / 25,
                  color: Color(0xffED1A4F),
                ),
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
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateClinic()));
                },
                child: Text(
                  "Add it here",
                  style: TextStyle(
                      color: Color(0xffe8364e), fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: (search.hospital.length == 0)
          ? buildNoContent()
          : buildSearchResult(width, height),
    );
  }

  SingleChildScrollView buildNoContent() {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Images/search.png"),
                        fit: BoxFit.cover)),
              ),
              Text(
                "Search Hospitals",
                style: TextStyle(
                    color: Color(0xffED1A4F),
                    fontSize: height / 35,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildSearchResult(double width, double height) {
    var search = Provider.of<SearchDoctorHospitalProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            height: height / 18,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Clinics matching your search",
                    style: TextStyle(color: Colors.black54),
                  ),
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
                itemCount: search.hospital.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorRemaningDetails(
                                  hospitalId: search.hospital[index].id),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height / 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${search.hospital[index].name}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: height / 50,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        "${search.hospital[index].location}",
                                        style: TextStyle(color: Colors.black38),
                                      ),
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
    );
  }
}
