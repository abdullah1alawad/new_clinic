import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/chat/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetManyChatsProvider extends ChangeNotifier {
  List<ChatModel>? chats;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getManyChats() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response =
          await DioHelper.getManyChats(CacheHelper().getData(key: kTOKEN));

      chats = (response.data[kDATA] as List)
          .map((chat) => ChatModel.fromJson(chat))
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
