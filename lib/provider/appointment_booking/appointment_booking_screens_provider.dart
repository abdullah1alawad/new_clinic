import 'package:flutter/material.dart';

class AppointmentBookingScreensProvider extends ChangeNotifier {
  int _screenNumber = 0, _clinicId = -1, _doctorId = -1, _subjectId = -1;
  String day = "", _time = "";
  final int _maxScreenNumber = 5;
  GlobalKey<FormState> formState = GlobalKey();

  int get screenNumber => _screenNumber;
  int get clinicId => _clinicId;
  int get doctorId => _doctorId;
  int get subjectId => _subjectId;
  String get time => _time;

  set screenNumber(int screenNumber) {
    if (screenNumber >= 0 && screenNumber < _maxScreenNumber) {
      _screenNumber = screenNumber;
      notifyListeners();
    }
  }

  set clinicId(int clinicId) {
    reSet();
    _clinicId = clinicId;
    notifyListeners();
  }

  set doctorId(int doctorId) {
    _doctorId = doctorId;
    notifyListeners();
  }

  set subjectId(int subjectId) {
    _subjectId = subjectId;
    notifyListeners();
  }

  set time(String time) {
    _time = time;
    notifyListeners();
  }

  void nextScreen() {
    screenNumber = _screenNumber + 1;
  }

  void previousScreen() {
    screenNumber = _screenNumber - 1;
  }

  void reSet() {
    _screenNumber = 0;
    _clinicId = -1;
    _doctorId = -1;
    _subjectId = -1;
    day = "";
    _time = "";
  }
}
