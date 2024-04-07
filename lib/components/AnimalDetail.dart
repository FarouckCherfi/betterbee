import 'package:betterbee/Provider.dart';
import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalDetail extends StatefulWidget {
  final MapEntry<String, dynamic> animal;

  const AnimalDetail({super.key, required this.animal});

  @override
  State<AnimalDetail> createState() => _AnimalDetail();
}

class _AnimalDetail extends State<AnimalDetail> {
  final FireBaseCallServices call = FireBaseCallServices();
  Map<String, dynamic> informations = {};

  @override
  void initState() {
    super.initState();
    getInformationsAndHints();
  }

  void getInformationsAndHints() async {
    Map<String, dynamic>? res =
        await call.getDescriptionAndHints(widget.animal.key);
    if (res != null) {
      setState(() {
        informations = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.animal.key;

    // ignore: unnecessary_null_comparison
    if (informations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(children: [
      Image.asset(
        widget.animal.value
            ? 'assets/animals/$name.png'
            : 'assets/animals/${name}_gris.png', // Replace with your image path
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.7,
        fit: BoxFit.cover,
      ),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          widget.animal.value ? widget.animal.key : "???",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        widget.animal.value
            ? Text(informations["description"])
            : Text(informations["hint"]),
        Text(informations["hint2"])
      ])
    ]);
  }
}
