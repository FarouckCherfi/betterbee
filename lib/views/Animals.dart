import 'package:betterbee/components/AnimalCard.dart';
import 'package:flutter/material.dart';

class Animals extends StatelessWidget {
  const Animals({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        animalList.length,
        (index) => AnimalCard(
          animal: animalList[index],
        ),
      ),
    );
  }
}

List<String> animalList = [
  'bee',
  'elephant',
  'giraffe',
  'zebra',
  'tiger',
  'monkey',
  'panda',
  'koala',
  'hippo',
  'rhino',
];
