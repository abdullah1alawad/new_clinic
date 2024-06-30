import 'package:flutter/material.dart';

class AppointmentBookingScreensProvider extends ChangeNotifier {
  int _screenNumber = 0;
  final int _maxScreenNumber = 4;

  int get screenNumber => _screenNumber;

  set screenNumber(int screenNumber) {
    if (screenNumber >= 0 && screenNumber < _maxScreenNumber) {
      _screenNumber = screenNumber;
      notifyListeners();
    }
  }

  void nextScreen() {
    screenNumber = _screenNumber + 1;
  }

  void previousScreen() {
    screenNumber = _screenNumber - 1;
  }

  void reSet() {
    _screenNumber = 0;
  }
}
