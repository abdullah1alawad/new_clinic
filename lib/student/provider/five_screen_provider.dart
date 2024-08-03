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
  int unReadNotify = 0;
  List<MarkModel> marks = [];
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

      // marks = (response.data[kDATA][kMARKS] as List)
      //     .map((mark) => MarkModel.fromjson(mark))
      //     .toList();
      calcSubjectMark();

      notifications = (response.data[kDATA][kNOTIFICATION] as List)
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();
      calcUnReadNotify();

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

  void addNotification(Map<String, dynamic> jsonData) {
    notifications!.insert(0, NotificationModel.fromJson(jsonData));
    calcUnReadNotify();
    notifyListeners();
  }

  void calcUnReadNotify() {
    unReadNotify = 0;
    for (int i = 0; i < notifications!.length; i++) {
      if (notifications![i].readAt == null) {
        unReadNotify++;
      }
    }

    notifyListeners();
  }

  void makeNotifyUnRead(String notifyId) {
    for (int i = 0; i < notifications!.length; i++) {
      if (notifications![i].id == notifyId) {
        notifications![i].readAt = "m.k";
      }
    }

    calcUnReadNotify();
  }

  void makeAllNotifyRead() {
    for (int i = 0; i < notifications!.length; i++) {
      notifications![i].readAt = "m.k";
    }

    unReadNotify = 0;
    notifyListeners();
  }

  void calcSubjectMark() {
    Map<String, List<AppointmentModel>> mp = {};
    Map<String, int> sum = {};
    for (int i = 0; i < completedAppointments!.length; i++) {
      if (mp[completedAppointments![i].subjectName] != null) {
        mp[completedAppointments![i].subjectName]!
            .add(completedAppointments![i]);
        sum[completedAppointments![i].subjectName] =
            sum[completedAppointments![i].subjectName]! +
                (completedAppointments![i].mark ?? 0);
      } else {
        mp[completedAppointments![i].subjectName] = [completedAppointments![i]];
        sum[completedAppointments![i].subjectName] =
            (completedAppointments![i].mark ?? 0);
      }
    }

    mp.forEach((key, value) {
      marks.add(
          MarkModel(subjectName: key, mark: sum[key]!, appointments: value));
    });
  }

  void fun() {
    print(CacheHelper().getData(key: kTOKEN));
  }
}
