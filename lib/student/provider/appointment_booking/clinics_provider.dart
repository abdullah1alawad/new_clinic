import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/student/dio/dio_helpers.dart';
import 'package:clinic_test_app/student/model/clinic_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClinicsProvider extends ChangeNotifier {
  List<ClinicModel>? clinics;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getClinics() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getClinics();

      clinics = (response.data[kDATA] as List)
          .map((clinic) => ClinicModel.fromJson(clinic))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }
}
