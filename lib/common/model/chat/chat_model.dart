import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/common/model/chat/message_model.dart';
import 'package:clinic_test_app/common/model/user_model.dart';

class ChatModel {
  final int id, createdBy;
  final String createdAt, updatedAt;
  final String? name;
  final MessageModel? lastMessage;
  final bool isPrivate;
  final UserModel otherUser;

  ChatModel({
    required this.id,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.lastMessage,
    required this.isPrivate,
    required this.otherUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatModel(
      id: jsonData[kID],
      createdBy: jsonData[kCREATEDBY],
      createdAt: jsonData[kCREATEDAT],
      updatedAt: jsonData[kUPDATEDAT],
      name: jsonData[kNAME],
      isPrivate: jsonData[kISPRIVATE],
      lastMessage: jsonData[kLASTMESSAGE] != null
          ? MessageModel.fromJson(jsonData[kLASTMESSAGE])
          : null,
      otherUser: UserModel.fromJson(jsonData[kOTHERUSER][0][kUSER]),
    );
  }
}
