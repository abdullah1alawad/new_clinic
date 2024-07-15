import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppointmentBookingProvider extends ChangeNotifier {
  ConnectionEnum? connecion;
  String? errorMessage;

  Future<void> bookAppointment(
    int clinicId,
    int doctorId,
    int subjectId,
    String date,
    List<Map<String, dynamic>> question,
  ) async {
    connecion = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kCLINICID: clinicId,
      kDOCTORID: doctorId,
      kSUBJECTID: subjectId,
      kDATE: date,
      kQUESTIONS: question,
    };

    print(data);

    try {
      var response = await DioHelper.bookAppointment(
          data, CacheHelper().getData(key: kTOKEN));

      connecion = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connecion = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
