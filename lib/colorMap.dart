import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class colormap extends StatelessWidget {
  final Map<String, Color> colorMap = {
    'A': Colors.blue,
    'B': Colors.green,
    'C': Colors.orange,
    'D': Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Graph with Color Map'),
        ),
        body: Center(
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
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: entry.value),
                    ),
                    SizedBox(height: 8),
                    Text(entry.key),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
