import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/coming_appointment_model.dart';
import 'package:clinic_test_app/model/completed_appointment_model.dart';
import 'package:clinic_test_app/model/mark_model.dart';
import 'package:clinic_test_app/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FiveScreenProvider extends ChangeNotifier {
  ProfileModel? profileModel;
  List<ComingAppointmentModel>? comingAppointments;
  List<CompletedAppointmentModel>? completedAppointments;
  List<MarkModel>? marks;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getFiveScreen() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response =
          await DioHelper.getFiveScreen(CacheHelper().getData(key: kTOKEN));

      //print("hello");
      profileModel = ProfileModel.fromJson(response.data[kDATA][kPROFILE]);
      comingAppointments =
          (response.data[kDATA][kAPPOINTMENTS][kCOMINGAPPOINTMENTS] as List)
              .map((comingAppointment) =>
                  ComingAppointmentModel.fromJson(comingAppointment))
              .toList();

      completedAppointments =
          (response.data[kDATA][kAPPOINTMENTS][kCOMPLETEDAPPOINTMENTS] as List)
              .map((completedAppointment) =>
                  CompletedAppointmentModel.fromJson(completedAppointment))
              .toList();

      // marks = (response.data[kDATA][kMARKS] as List)
      //     .map((mark) => MarkModel.fromjson(mark))
      //     .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }

  void fun() {
    print(CacheHelper().getData(key: kTOKEN));
  }
}
