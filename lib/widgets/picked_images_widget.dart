import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PickedImagesWidget extends StatefulWidget {
  final List<File> images;
  const PickedImagesWidget({Key? key, required this.images}) : super(key: key);

  @override
  _PickedImagesWidgetState createState() => _PickedImagesWidgetState();
}

class _PickedImagesWidgetState extends State<PickedImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: widget.images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration:
                  BoxDecoration(image: DecorationImage(image: FileImage(i))),
            );
          },
        );
      }).toList(),
    );
  }
}
