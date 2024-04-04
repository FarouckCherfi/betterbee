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
  late MapEntry<String, dynamic> selectedAnimal;
  Map<String, dynamic> animalList = {};
  final FireBaseCallServices call = FireBaseCallServices();

  @override
  void initState() {
    super.initState();
    getAnimals();
  }

  void getAnimals() async {
    String? uid = Provider.of<AppProvider>(context, listen: false).uid;

    Map<String, dynamic>? animals = await call.getAnimals(uid!);
    if (animals != null) {
      setState(() {
        animalList = animals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<AppProvider>(context).detail
        ? Column(children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
            AnimalDetail(animal: selectedAnimal),
          ])
        : GridView.count(
            crossAxisCount: 3,
            children: animalList.entries.map((entry) {
              return InkWell(
                  onTap: () {
                    setState(() {
                      Provider.of<AppProvider>(listen: false, context)
                          .setSelectedAnimal(true);
                      Provider.of<AppProvider>(listen: false, context)
                          .setDetail(true);
                      selectedAnimal = entry;
                    });
                  },
                  child: AnimalCard(animal: entry));
            }).toList(),
          );
  }
}
