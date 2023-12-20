import 'package:flutter/material.dart';

class MultiNumberIncreaseProvider extends ChangeNotifier {
  int value = 0;

  int get Value {
    return value;
  }

  void increase() {
    value++;
    notifyListeners();
  }

  void reduce() {
    value--;
    notifyListeners();
  }
}
