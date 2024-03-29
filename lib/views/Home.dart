// ignore: file_names

import 'package:betterbee/Animal.dart';
import 'package:betterbee/Provider.dart';
import 'package:betterbee/components/AnimalHomeImage.dart';
import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  late MapEntry<String, dynamic> selectedAnimal;
  Map<String, dynamic> animalList = {};
  List<Animal> dataBaseAnimals = [];
  final FireBaseCallServices call = FireBaseCallServices();

  @override
  void initState() {
    super.initState();
    getUserAnimals();
    getDataBaseAnimals();
  }

  void getDataBaseAnimals() async {
    List<Animal> animals = await call.getDataBaseAnimals();
    if (animals != null) {
      setState(() {
        dataBaseAnimals = animals;
      });
    }
  }

  void getUserAnimals() async {
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
    String? uid = Provider.of<UserProvider>(context).uid;

    Animal? getAnimalDetails(String name) {
      for (Animal animal in dataBaseAnimals) {
        if (animal.name == name) {
          return animal;
        }
      }
      return null;
    }

    return Stack(
      children: [
        // Background image
        Image.asset(
          'assets/BackGround3.jpeg',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        // Overlay animal images
        ...animalList.entries.map((entry) {
          Animal? animal = getAnimalDetails(entry.key);
          if (animal != null) {
            return AnimalHomeImage(
              animal: entry,
              positionTop: animal.positionTop,
              positionLeft: animal.positionLeft,
              height: animal.height,
              width: animal.width,
            );
          } else {
            // Handle if animal details are not found
            return const SizedBox(); // Placeholder or any other widget
          }
        }),
      ],
    );
  }
}
