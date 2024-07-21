import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/appointment_model.dart';
import 'package:clinic_test_app/model/mark_model.dart';
import 'package:clinic_test_app/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FiveScreenProvider extends ChangeNotifier {
  UserModel? user;
  List<AppointmentModel>? comingAppointments;
  List<AppointmentModel>? completedAppointments;
  List<MarkModel>? marks;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getFiveScreen() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response =
          await DioHelper.getFiveScreen(CacheHelper().getData(key: kTOKEN));

      user = UserModel.fromJson(response.data[kDATA][kPROFILE]);

      comingAppointments =
          (response.data[kDATA][kAPPOINTMENTS][kCOMINGAPPOINTMENTS] as List)
              .map((comingAppointment) =>
                  AppointmentModel.fromJson(comingAppointment))
              .toList();

      completedAppointments =
          (response.data[kDATA][kAPPOINTMENTS][kCOMPLETEDAPPOINTMENTS] as List)
              .map((completedAppointment) =>
                  AppointmentModel.fromJson(completedAppointment))
              .toList();

      marks = (response.data[kDATA][kMARKS] as List)
          .map((mark) => MarkModel.fromjson(mark))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }

  void cancelAppointment(int appointmentId) {
    comingAppointments
        ?.removeWhere((appointment) => appointment.id == appointmentId);
    notifyListeners();
  }

  void addAppointment(AppointmentModel appointment) {
    comingAppointments!.add(appointment);
    notifyListeners();
  }

  void fun() {
    print(CacheHelper().getData(key: kTOKEN));
  }
}
