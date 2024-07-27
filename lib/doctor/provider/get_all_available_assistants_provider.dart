import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/core/enum/connection_enum.dart';
import '../../common/core/utils/app_constants.dart';
import '../../common/model/user_model.dart';

import '../dio/dio_helpers.dart';
import '../model/appointment_model.dart';

class GetAllAvailableAssistantsProvider extends ChangeNotifier {
  AppointmentModel? appointment;
  List<UserModel>? assistants;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getAllAvailableAssistants(int appointmentId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getAllAvailableAssistants(appointmentId);

      appointment = AppointmentModel.fromJson(response.data[kDATA][kPROCESS]);
      assistants = (response.data[kDATA][kASSISTANTS] as List)
          .map((assistant) => UserModel.fromJson(assistant))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      print(e.response!.data[kMESSAGE]);
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
