import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/shared/components/components.dart';
import 'package:idental/upload.dart';
import '../model/slide_model.dart';
import '../object_detection/detector.dart';

class SlideItem_model extends StatelessWidget {
  final int index;
  SlideItem_model(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 250,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(slideList_model[index].title,
                          style: GoogleFonts.parisienne(
                            fontSize: 30,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 200,
                        child: Image.asset(slideList_model[index].imageUrl),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      defaultButton(230.0, 50.0, 'Diagnosis', true, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => index == 2
                                ? detector()
                                : UploadScreen(
                                    index: index,
                                  ),
                          ),
                        );
                      })
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
