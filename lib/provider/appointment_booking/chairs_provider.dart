import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChairsProvider extends ChangeNotifier {
  Map<String, Map<String, int>> data = {};
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getChairs(int doctorId, int clinicId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getChairs(clinicId, doctorId);

      response.data[kDATA].forEach((key, value) {
      data[key] = Map<String, int>.from(value);
    });

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }
}
