import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  List<bool> leds = [
    false,
    false,
    false,
    false,
  ];

  void switchLed({required int ledNum}) {
    leds[ledNum - 1] = !leds[ledNum - 1];
    notifyListeners();
  }
}
