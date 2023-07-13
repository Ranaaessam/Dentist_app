import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/ZoomableContainer.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:idental/object_detection/LoaderState.dart';

class detector extends StatefulWidget {
  const detector({super.key});

  @override
  State<detector> createState() => _detectorState();
}

class _detectorState extends State<detector> {
  late ModelObjectDetection _objectModel;
  String? _imagePrediction;
  List? _prediction;
  File? _image;
  ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];
  bool firststate = false;
  bool message = true;
  @override
  final Map<String, Color> colorMap = {
    'Cavity': Colors.deepPurpleAccent,
    'Filling': Colors.teal,
    'Implant': Colors.yellow,
    'Impacted tooth': Colors.redAccent,
    'Infected teeth': Colors.orange,
  };
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    String pathObjectDetectionModel = "assets/multi-disease.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 5, 640, 640,
          labelPath: "assets/multi-disease.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  void handleTimeout() {
    setState(() {
      firststate = true;
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  //running detections on image
  Future runObjectDetection() async {
    setState(() {
      firststate = false;
      message = false;
    });
    //pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    objDetect = await _objectModel.getImagePrediction(
        await File(image!.path).readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3);
    objDetect.forEach((element) {
    });
    scheduleTimeout(5 * 1000);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: const Text("OBJECT DETECTOR APP")),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image with Detections....
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Caries and Others',
                    style: GoogleFonts.parisienne(
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          !firststate
              ? !message
                  ? Center(child: LoaderState())
                  : Text("")
              : Expanded(
                  flex: 5,
                  child: ZoomableContainer(
                      image: Container(
                    child: _objectModel.renderBoxesOnImage(_image!, objDetect),
                  )),
                ),
          SizedBox(
            height: 10,
          ),
          _image != null
              ? Expanded(
                  flex: 5,
                  child: Container(
                    width: 300,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: colorMap.entries.map((entry) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              // color: entry.value,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: entry.value),
                            ),
                            SizedBox(width: 15),
                            Text(entry.key),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              : Expanded(
                  flex: 5,
                  child: Visibility(
                    visible: _imagePrediction != null,
                    child: Text("here $_imagePrediction"),
                  ),
                ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => runObjectDetection(),
              child: Container(
                width: size.width - 10,
                height: 50,
                alignment: AlignmentDirectional.centerEnd,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      Colors.teal,
                      Color(0xFF80CBC4),
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Take a Photo       ",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => runObjectDetection(),
              child: Container(
                width: size.width - 10,
                height: 50,
                alignment: AlignmentDirectional.centerEnd,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      Colors.teal,
                      Color(0xFF80CBC4),
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Pick from gallery",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
