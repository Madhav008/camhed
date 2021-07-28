import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/S1.png',
    title: 'Fresh Food & Everything',
    description: 'Discover the best foods from over a million restaurants and fast deliver to your doorstep',
  ),
  Slide(
    imageUrl: 'assets/S2.png',
    title: 'Fast Delivery',
    description: 'Fast delivery to your home, office and wherever you are',
  ),
  Slide(
    imageUrl: 'assets/S3.png',
    title: 'Enjoy Today',
    description: 'Real time tracking of your food on the app once you placed the order',
  ),
];