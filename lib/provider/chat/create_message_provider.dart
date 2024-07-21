import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/chat/message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateMessageProvider extends ChangeNotifier {
  MessageModel? message;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> createMessage(int chatId, String message) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kCHATID: chatId,
      kMESSAGE: message,
    };

    try {
      var response = await DioHelper.createMessage(
        data,
        CacheHelper().getData(key: kTOKEN),
      );

      this.message = MessageModel.fromJson(response.data[kDATA]);

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
