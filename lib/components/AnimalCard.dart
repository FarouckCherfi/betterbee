// ignore: file_names
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final MapEntry<String, dynamic> animal;

  const AnimalCard({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    String name = animal.key;
    return Card(
      child: Column(
        children: [
          Image.asset(
            animal.value
                ? 'assets/animals/$name.png'
                : 'assets/animals/${name}_gris.png', // Replace with your image path
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            animal.value ? animal.key : "???",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
