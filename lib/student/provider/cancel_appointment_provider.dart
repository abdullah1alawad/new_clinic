import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/student/dio/dio_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CancelAppointmentProvider extends ChangeNotifier {
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> cancelAppointment(int appointmentId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.cancelAppoinment(appointmentId);

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
