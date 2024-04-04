import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String? _uid;
  bool _selectedAnimal = false;
  bool _detail = false;

  String? get uid => _uid;
  bool get detail => _detail;
  bool get selectedAnimal => _selectedAnimal;

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void setDetail(bool detail) {
    _detail = detail;
    notifyListeners();
  }

  void setSelectedAnimal(bool animal) {
    _selectedAnimal = animal;
    notifyListeners();
  }
}
