import 'package:betterbee/components/CustomNavigationBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return PopScope(
        canPop: false,
        child: Scaffold(
            bottomNavigationBar: const CustomNavigationBar(),
            body: Stack(children: [
              // Background Image
              Image.asset(
                'assets/BackGround3.jpg',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ])));
  }
}
