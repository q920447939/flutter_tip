import 'package:flutter/material.dart';

class SingleNumberIncreaseProvider extends ChangeNotifier {
  int value = 0;

  int get Value {
    return value;
  }

  void increase() {
    value++;
    notifyListeners();
  }
}
