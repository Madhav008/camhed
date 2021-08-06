import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class CreateDoctorProfile extends StatefulWidget {
  const CreateDoctorProfile({Key key}) : super(key: key);

  @override

  _CreateDoctorProfileState createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
  var _city = [
    "Una",
    "Hamirpur",
    "Delhi",
  ];
  var _speciality = [
    "Covid-19",
    "cancer",
    "Skin",
  ];
  var _currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile",style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 20),
            child: Text("SAVE",style: TextStyle(color: Color(0xffe8364e),fontSize: height/55,fontWeight: FontWeight.w500),)
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffe8364e)),

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(color: Colors.black38),),
              TextFormField(
                // onChanged: (value) {
                //   doctorRegisterValidation.changeAddress(value);
                // },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black38),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Please select expense',
                          labelText: "Enter Your City",
                      ),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _city.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black38),
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Speciality',
                        labelText: "Enter Your Speciality",
                      ),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _speciality.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("Gender",style: TextStyle(color: Colors.black38),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            // doctorRegisterValidation.setAgree();
                          },
                        ),
                        Text("Male")
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {
                              // doctorRegisterValidation.setAgree();
                            },
                          ),
                          Text("Female")
                        ],
                      ),
                    ),


                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text("Education",style: TextStyle(color: Colors.black38),),
              ),
              TextFormField(
                // onChanged: (value) {
                //   doctorRegisterValidation.changeAddress(value);
                // },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Eg. MBBS",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Experience",style: TextStyle(color: Colors.black38),),
              ),
              TextFormField(
                // onChanged: (value) {
                //   doctorRegisterValidation.changeAddress(value);
                // },
                decoration: InputDecoration(
                  // errorText: doctorRegisterValidation.address.error,
                  hintText: "Years of experience",
                  hintStyle: TextStyle(color: Colors.black38),
                  alignLabelWithHint: false,
                  helperText: "",
                  fillColor: Colors.white,

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
