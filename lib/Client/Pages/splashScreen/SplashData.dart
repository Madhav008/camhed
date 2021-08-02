import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
     this.imageUrl,
     this.title,
     this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'Images/doctor.png',
    title: 'No Waiting',
    description: 'Hassle Free Appointment',
  ),
  Slide(
    imageUrl: 'Images/Queue.png',
    title: 'Join a Queue',
    description: 'Get in a queue remotely from your home',
  ),
  Slide(
    imageUrl: 'Images/Cash.png',
    title: 'Online Payment',
    description: 'Pay online for your consultation',
  ),
];