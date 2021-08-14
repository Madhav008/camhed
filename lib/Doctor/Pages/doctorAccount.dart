import 'package:flutter/material.dart';

import 'changeSessions.dart';

class DoctorAccount extends StatefulWidget {
  const DoctorAccount({Key key}) : super(key: key);

  @override
  _DoctorAccountState createState() => _DoctorAccountState();
}

class _DoctorAccountState extends State<DoctorAccount> {

  TimeOfDay initialTime = TimeOfDay.now();
  List<TimeOfDay> start_time = [];
  List<TimeOfDay> end_time = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff1f0f6),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height / 4.5,
                    width: width,
                    color: Color(0xffe8364e),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child:
                          // (file != null)
                          //     ? Container(
                          //   height: height / 10,
                          //   width: height / 10,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(200),
                          //       color: Colors.white,
                          //       image: DecorationImage(
                          //           image: FileImage(file),
                          //           fit: BoxFit.cover)),
                          // )
                          //     :
                          Container(
                            height: height / 10,
                            width: height / 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.white,
                                image: DecorationImage(
                                    image:
                                    AssetImage("Images/userlogo.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "Aditya",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: height / 50),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   nameController.text = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "Your Name",
                              suffixIcon: Icon(Icons.person),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Mobile",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   phone = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "7876200034",
                              suffixIcon: Icon(Icons.phone_android),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "E-mail",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   emailController.text = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "Your Email",
                              suffixIcon: Icon(Icons.mail),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Fee",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   addressController.text = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "500 \$",
                              suffixIcon: Icon(Icons.money),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Experiance",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   addressController.text = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "10 Years",
                              suffixIcon: Icon(Icons.timeline),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Position",
                          style: TextStyle(
                              color: Colors.black38, fontSize: height / 55),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            style: TextStyle(
                              fontSize: height / 60, // This is not so important
                            ),
                            // onChanged: (value) {
                            //   addressController.text = value;
                            // },
                            decoration: InputDecoration(
                              // errorText: doctorRegisterValidation.address.error,
                              hintText: "MBBS",
                              suffixIcon: Icon(Icons.person_outline),
                              hintStyle: TextStyle(color: Colors.black38),
                              alignLabelWithHint: false,
                              helperText: "",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Selected Sessions",
                                style: TextStyle(color: Colors.black38),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeSessions()));
                                },
                                  child: Text("Change...",style: TextStyle(color: Colors.orange),))
                            ],
                          ),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: start_time.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15, top: 15,right: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Material(
                                          elevation: 1,
                                          child: Container(
                                              height: height / 15,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Row(

                                                      children: [
                                                        Text(
                                                          start_time[index].hour.toString() +
                                                              ":" +
                                                              start_time[index].minute.toString(),
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: height / 50,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 15),
                                                          child: Text("To"),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 15),
                                                          child: Text(
                                                            end_time[index].hour.toString() +
                                                                ":" +
                                                                end_time[index].minute.toString(),
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: height / 50,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),



                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            child: Container(
                              height: height / 13,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(0xffe8364e),
                                  borderRadius:
                                  BorderRadius.circular(height / 80)),
                              child: Center(
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }
}

