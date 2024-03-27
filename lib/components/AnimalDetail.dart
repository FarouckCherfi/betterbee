import 'package:flutter/material.dart';

class AnimalDetail extends StatelessWidget {
  final MapEntry<String, dynamic> animal;

  const AnimalDetail({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("waiting"));
  }
}
