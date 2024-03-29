// ignore: file_names
import 'package:flutter/material.dart';

class AnimalHomeImage extends StatelessWidget {
  final double positionTop;
  final double positionLeft;
  final double height;
  final double width;

  final MapEntry<String, dynamic> animal;

  const AnimalHomeImage({
    super.key,
    required this.animal,
    required this.positionTop,
    required this.positionLeft,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    String name = animal.key;
    var imageUrl = 'assets/animals/$name.png';
    if (animal.value == true) {
      return Positioned(
        top: MediaQuery.of(context).size.height * positionTop.toDouble(),
        left: MediaQuery.of(context).size.width * positionLeft.toDouble(),
        child: Image.asset(
          imageUrl,
          width: MediaQuery.of(context).size.width * width.toDouble(),
          height: MediaQuery.of(context).size.width * height.toDouble(),
        ),
      );
    } else {
      return Container();
    }
  }
}
