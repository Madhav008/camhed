import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height:  height/180,
      width: width/30,
      decoration: BoxDecoration(
        color: isActive ? Color(0xffe8364e) : Colors.black54,
        // borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}