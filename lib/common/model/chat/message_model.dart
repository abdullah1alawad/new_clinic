import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/core/utils/app_services.dart';
import 'package:clinic_test_app/common/model/user_model.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class MessageModel {
  final int id, chatId, userId;
  final String message, createdAt, updatedAt;
  final UserModel user;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      id: jsonData[kID],
      chatId: jsonData[kCHATID],
      userId: jsonData[kUSERID],
      message: jsonData[kMESSAGE],
      createdAt: jsonData[kCREATEDAT],
      updatedAt: jsonData[kUPDATEDAT],
      user: UserModel.fromJson(jsonData[kUSER]),
    );
  }

  ChatMessage get toChatMessage {
    return ChatMessage(
      user: user.toChatUser,
      text: message,
      createdAt: parseDateTime(createdAt),
    );
  }
}
