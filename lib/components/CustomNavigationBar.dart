// ignore: file_names
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: Colors.amber,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.park), label: "Animals"),
          NavigationDestination(icon: Icon(Icons.contacts), label: "Friends"),
          //NavigationDestination(icon: Icon(Icons.logout), label: "Logout")
        ]);
  }
}
