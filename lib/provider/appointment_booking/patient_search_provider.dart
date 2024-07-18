import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/patient_info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PatientSearchProvider extends ChangeNotifier {
  TextEditingController dataController = TextEditingController();
  List<PatientInfoModel>? patientInfo;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> searchForPatient(int clinicId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {

      var response =
          await DioHelper.searchForPatient(clinicId, dataController.text, CacheHelper().getData(key: kTOKEN));

      patientInfo = (response.data[kDATA][kQUESTIONS] as List)
          .map((question) => PatientInfoModel.fromJson(question))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
