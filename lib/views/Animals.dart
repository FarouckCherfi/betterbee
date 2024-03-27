import 'package:betterbee/components/AnimalCard.dart';
import 'package:betterbee/Provider.dart';
import 'package:betterbee/components/AnimalDetail.dart';
import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Animals extends StatefulWidget {
  const Animals({super.key});

  @override
  State<Animals> createState() => _Animals();
}

class _Animals extends State<Animals> {
  bool showdetails = false;
  late MapEntry<String, dynamic> selectedAnimal;
  Map<String, dynamic> animalList = {};
  final FireBaseCallServices call = FireBaseCallServices();


  @override
  void initState() {
    super.initState();
    getAnimals();
  }

  void getAnimals() async {
    String? uid = Provider.of<UserProvider>(context, listen: false).uid;

    Map<String, dynamic>? animals = await call.getAnimals(uid!);
    if (animals != null) {
      setState(() {
        animalList = animals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showdetails) {
      return GridView.count(
        crossAxisCount: 2,
        children: animalList.entries.map((entry) {
          return InkWell(
              onTap: () {
                setState(() {
                  showdetails = true;
                  selectedAnimal = entry;
                });
              },
              child: AnimalCard(animal: entry));
        }).toList(),
      );
    } else {
      return Column(children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
        Row(children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  showdetails = false;
                });
              },
              child: const Text('Back'))
        ]),
        AnimalDetail(animal: selectedAnimal),
      ]);
    }
  }
}
