import 'package:clinic_test_app/common/core/enum/connection_enum.dart';
import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/dio/dio_helpers.dart';
import 'package:clinic_test_app/common/model/chat/chat_model.dart';
import 'package:clinic_test_app/common/model/chat/message_model.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetChatMessagesProvider extends ChangeNotifier {
  List<MessageModel> messages = [];
  List<MessageModel>? newMessages;
  int page = 1;
  ChatModel? chat;
  bool lastPage = false;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getChatMessages() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getChatMessages(chat!.id, page);

      newMessages = (response.data[kDATA] as List)
          .map((message) => MessageModel.fromJson(message))
          .toList();

      if (newMessages!.isNotEmpty) {
        page++;
        messages = [...messages, ...newMessages!];
      } else {
        lastPage = true;
      }

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }

  List<ChatMessage> get uiMessages {
    return messages.map((e) => e.toChatMessage).toList();
  }

  void addMessage(MessageModel message) {
    messages.insert(0, message);
    notifyListeners();
  }

  void reset(ChatModel chat) {
    messages = [];
    page = 1;
    this.chat = chat;
    lastPage = false;
  }
}
