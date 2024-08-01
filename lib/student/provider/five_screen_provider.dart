import 'package:clinic_test_app/common/cache/cache_helper.dart';
import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/student/dio/dio_helpers.dart';
import 'package:clinic_test_app/student/model/appointment_model.dart';
import 'package:clinic_test_app/student/model/mark_model.dart';
import 'package:clinic_test_app/common/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/notification/notification_model.dart';

class FiveScreenProvider extends ChangeNotifier {
  UserModel? user;
  List<AppointmentModel>? comingAppointments;
  List<AppointmentModel>? completedAppointments;
  List<NotificationModel>? notifications;
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

      notifications = (response.data[kDATA][kNOTIFICATION] as List)
          .map((notification) => NotificationModel.fromJson(notification))
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

  AppointmentModel getAppoointment(int appointmentId) {
    return comingAppointments!
        .firstWhere((appointment) => appointment.id == appointmentId);
  }

  void fun() {
    print(CacheHelper().getData(key: kTOKEN));
  }
}
