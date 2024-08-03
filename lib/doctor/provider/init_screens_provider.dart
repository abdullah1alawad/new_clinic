import 'package:clinic_test_app/common/cache/cache_helper.dart';
import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/model/user_model.dart';
import '../model/subprocess_model.dart';
import '../dio/dio_helpers.dart';
import '../model/appointment_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/notification/notification_model.dart';

class InitScreensProvider extends ChangeNotifier {
  UserModel? user;
  List<AppointmentModel>? comingAppointments;
  List<AppointmentModel>? completedAppointments;
  List<NotificationModel>? notifications;
  int unReadNotify = 0;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getInitScreens() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response =
          await DioHelper.getInitScreens(CacheHelper().getData(key: kTOKEN));

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

  void addMark(int index, SubprocessModel subProcess) {
    completedAppointments![index].subprocesses.add(subProcess);
    notifyListeners();
  }

  void deleteMark(int index, int id) {
    completedAppointments![index].subprocesses.removeWhere(
          (element) => element.id == id,
        );
    notifyListeners();
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

  void fun() {
    print(CacheHelper().getData(key: kTOKEN));
  }
}
