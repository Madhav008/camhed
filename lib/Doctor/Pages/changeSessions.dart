import 'package:flutter/material.dart';

class ChangeSessions extends StatefulWidget {
  const ChangeSessions({Key key}) : super(key: key);

  @override
  _ChangeSessionsState createState() => _ChangeSessionsState();
}

class _ChangeSessionsState extends State<ChangeSessions> {
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
          "Sessions",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffe8364e),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
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
                                              "10" +
                                                  ":" +
                                                  "30",
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
                                                "12" +
                                                    ":" +
                                                    "30",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height / 50,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: Icon(Icons.cancel,color: Color(0xffe8364e),),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ));
                }),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Add More Appointment Sessions",
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 15),
              child: Row(
                children: [
                  InkWell(
                      onTap: () async {
                        TimeOfDay pickedTime = await showTimePicker(
                          context: context,
                          initialTime: initialTime,
                          builder: (BuildContext context, Widget child) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: child,
                            );
                          },
                        );
                        setState(() {
                          start_time.add(pickedTime);
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffe8364e),
                              borderRadius:
                              BorderRadius.circular(height / 100)),
                          height: height / 20,
                          width: width / 4,
                          child: Center(
                              child: Text(
                                "Start",
                                style: TextStyle(color: Colors.white),
                              )))),
                  InkWell(
                      onTap: () async {
                        TimeOfDay pickedTime = await showTimePicker(
                          context: context,
                          initialTime: initialTime,
                          builder: (BuildContext context, Widget child) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: child,
                            );
                          },
                        );
                        setState(() {
                          end_time.add(pickedTime);
                        });

                        print(start_time);
                        // print(end_time);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffe8364e),
                                borderRadius:
                                BorderRadius.circular(height / 100)),
                            height: height / 20,
                            width: width / 4,
                            child: Center(
                                child: Text(
                                  "End",
                                  style: TextStyle(color: Colors.white),
                                ))),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Text(
                            "(*You can add multiple sessions)",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: height / 70),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
