import 'package:camhed/Doctor/DoctorProvider/TimeSessaionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeSessions extends StatefulWidget {
  @override
  _ChangeSessionsState createState() => _ChangeSessionsState();
}

class _ChangeSessionsState extends State<ChangeSessions> {
  @override
  void initState() {
    super.initState();
    Provider.of<TimeSessionProvider>(context, listen: false).getProfileData();
  }

  TimeOfDay initialTime = TimeOfDay.now();
  var start_time;
  var end_time;
  @override
  Widget build(BuildContext context) {
    var timeSeesion = Provider.of<TimeSessionProvider>(context);
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
                itemCount: timeSeesion.startTime.length,
                itemBuilder: (context, index) {
                  var startTime = timeSeesion.startTime[index];
                  startTime = startTime.split("(")[1].split(")")[0];

                  var endTime = timeSeesion.endTime[index];
                  endTime = endTime.split("(")[1].split(")")[0];
                  return InkWell(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          elevation: 1,
                          child: Container(
                              height: height / 15,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          startTime,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height / 50,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text("To"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            endTime,
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
                                    child: InkWell(
                                      onTap: () {
                                        timeSeesion.removeSession(
                                            timeSeesion.startTime[index],
                                            timeSeesion.endTime[index]);
                                      },
                                      child: Icon(
                                        Icons.cancel,
                                        color: Color(0xffe8364e),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ));
                }),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
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
              padding: const EdgeInsets.only(top: 20, left: 15),
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
                          start_time = pickedTime;
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
                          end_time = pickedTime;
                        });

                        // print(start_time);
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
                                color: Colors.black38, fontSize: height / 70),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  timeSeesion.updateTime(
                      start_time.toString(), end_time.toString());
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffe8364e),
                        borderRadius: BorderRadius.circular(height / 100)),
                    height: height / 20,
                    width: width / 4,
                    child: Center(
                        child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
