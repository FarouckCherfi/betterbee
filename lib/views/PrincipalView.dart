import 'package:betterbee/Provider.dart';
import 'package:betterbee/components/CustomNavigationBar.dart';
import 'package:betterbee/healthkit/healthkit.dart';
import 'package:betterbee/views/Animals.dart';
import 'package:betterbee/views/Friends.dart';
import 'package:betterbee/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/health.dart';
import 'package:provider/provider.dart';

class PrincipalViewPage extends StatefulWidget {
  const PrincipalViewPage({super.key});

  @override
  State<PrincipalViewPage> createState() => _PrincipalViewPage();
}

class _PrincipalViewPage extends State<PrincipalViewPage> {
  int _selectedIndex = 0;
  final UtilityHealth _healthkit = UtilityHealth();

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? user = Provider.of<AppProvider>(context).uid;
    _healthkit.authorize();
    _healthkit.fetchDataTotal(user!, HealthDataType.FLIGHTS_CLIMBED);
    _healthkit.fetchDataTotal(user!, HealthDataType.STEPS);

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
