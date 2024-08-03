import 'package:clinic_test_app/common/cache/cache_helper.dart';
import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/dio/dio_helpers.dart';
import 'package:clinic_test_app/common/model/chat/chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/chat/message_model.dart';

class GetManyChatsProvider extends ChangeNotifier {
  List<ChatModel>? chats;
  int unRead = 0;
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
      calcUnReadMessages();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }

  void updateLastMessage(int chatId, Map<String, dynamic> data) {
    int chatIndex = -1;
    for (int i = 0; i < chats!.length; i++) {
      if (chats![i].id == chatId) {
        chatIndex = i;
        break;
      }
    }

    //print(data['chat']);
    if (chatIndex != -1) {
      chats![chatIndex].lastMessage =
          MessageModel.fromJson(data['chat']['last_message']);
      chats![chatIndex].isRead = false;
    } else {
      chats!.add(ChatModel.fromJson(data['chat']));
    }

    calcUnReadMessages();
  }

  void calcUnReadMessages() {
    unRead = 0;
    for (int i = 0; i < chats!.length; i++) {
      if (!chats![i].isRead) {
        unRead++;
      }
    }

    notifyListeners();
  }

  void makeItRead(int chatId) {
    for (int i = 0; i < chats!.length; i++) {
      if (chats![i].id == chatId) {
        chats![i].isRead = true;
        break;
      }
    }
    calcUnReadMessages();
  }
}
