import 'package:clinic_test_app/common/cache/cache_helper.dart';
import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/dio/dio_helpers.dart';
import 'package:clinic_test_app/common/model/chat/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetSingleChatProvider extends ChangeNotifier {
  ChatModel? chat;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getSingleChat(int chatId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getSingleChat(
        chatId,
        CacheHelper().getData(key: kTOKEN),
      );

      chat = ChatModel.fromJson(response.data[kDATA]);

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}