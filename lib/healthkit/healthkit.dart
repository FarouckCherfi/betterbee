import 'dart:convert';

import 'package:betterbee/firebase/firebase_call/firebase_call_services.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:carp_serializable/carp_serializable.dart';

class UtilityHealth {
  Future<void> authorize() async {
    List<HealthDataAccess> permissions =
        dataTypeKeysIOS.map((e) => HealthDataAccess.READ).toList();
    bool? hasPermissions = await Health()
        .hasPermissions(dataTypeKeysIOS, permissions: permissions);

    hasPermissions = false;

    if (!hasPermissions) {
      try {
        await Health()
            .requestAuthorization(dataTypeKeysIOS, permissions: permissions);
      } catch (error) {
        debugPrint("Exception in authorize : $error");
      }
    }
  }

  Future<double> fetchDataTotal(String uid, HealthDataType arg) async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    final types = [arg];
    final FireBaseCallServices fireBaseCallServices = FireBaseCallServices();

    List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types, startTime: yesterday, endTime: now);

    healthData = Health().removeDuplicates(healthData);

    double total = 0;
    for (var data in healthData) {
      total += (data.value as NumericHealthValue).numericValue;
    }

    return total;
  }
}
