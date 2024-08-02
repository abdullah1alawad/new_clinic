import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../cache/cache_helper.dart';
import '../core/enum/connection_enum.dart';
import '../core/utils/app_constants.dart';
import '../dio/dio_helpers.dart';

class MakeNotificationReadProvider extends ChangeNotifier{
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> makeNotificationRead(String notificationId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.makeNotificationRead(
        notificationId,
        CacheHelper().getData(key: kTOKEN),
      );


      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }

}