import 'package:betterbee/Provider.dart';
import 'package:betterbee/components/AnimalDetail.dart';
import 'package:betterbee/components/CustomNavigationBar.dart';
import 'package:betterbee/views/Animals.dart';
import 'package:betterbee/views/Friends.dart';
import 'package:betterbee/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrincipalViewPage extends StatefulWidget {
  const PrincipalViewPage({super.key});

  @override
  State<PrincipalViewPage> createState() => _PrincipalViewPage();
}

class _PrincipalViewPage extends State<PrincipalViewPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
            body: Stack(children: [
              if (_selectedIndex == 0) const MyHome(),
              if (_selectedIndex == 1) const Animals(),
              if (_selectedIndex == 2) const Friends(),
            ])));
  }
}
