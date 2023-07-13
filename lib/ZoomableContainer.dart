import 'package:flutter/material.dart';

class ZoomableContainer extends StatefulWidget {
  final Container image;
  ZoomableContainer({required this.image});
  @override
  _ZoomableContainerState createState() => _ZoomableContainerState();
}
class _ZoomableContainerState extends State<ZoomableContainer> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        _previousScale = _scale;
        setState(() {});
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        _scale = _previousScale * details.scale;
        setState(() {});
      },
      child: InteractiveViewer(
        minScale: 1.0,
        maxScale: 4.0,
        child: widget.image,
        boundaryMargin: EdgeInsets.all(double.infinity),
      ),
    );
  }
}
