import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:flutter/material.dart';

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

    return Column(children: [
      Image.asset(
        widget.animal.value
            ? 'assets/animals/$name.png'
            : 'assets/animals/${name}_gris.png', // Replace with your image path
        width: 400,
        height: 400,
        fit: BoxFit.cover,
      ),
      const SizedBox(height: 8),
      Text(
        widget.animal.value ? widget.animal.key : "???",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 18),
      widget.animal.value
          ? Text(informations["description"])
          : Text(informations["hint"]),
      Text(informations["hint2"])
    ]);
  }
}
