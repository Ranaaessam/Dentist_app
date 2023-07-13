import 'package:flutter/material.dart';
import '../model/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          slideList[index].title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.teal,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
