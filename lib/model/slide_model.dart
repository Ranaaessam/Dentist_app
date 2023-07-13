import 'package:flutter/material.dart';

class Slide_model {
  final String imageUrl;
  final String title;

  Slide_model({
    required this.imageUrl,
    required this.title,
  });
}

final slideList_model = [
  Slide_model(
    imageUrl: 'images/perio4.jpg',
    title: 'Periodontal',
  ),
  Slide_model(
    imageUrl: 'images/oralcancer.png',
    title: 'Oral Cancer',
  ),
  Slide_model(
    imageUrl: 'images/caries2.png',
    title: 'Caries and others',
  ),
];
