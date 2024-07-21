import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class UserModel {
  final String email, username, name, gender, phone, nationalId;
  final String? photo;
  final int id;

  UserModel({
    required this.email,
    required this.username,
    required this.name,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.nationalId,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData[kID],
      email: jsonData[kEMAIL],
      username: jsonData[kUSERNAME],
      name: jsonData[kNAME],
      gender: jsonData[kGENDER],
      phone: jsonData[kPHONE],
      photo: jsonData[kPHOTO],
      nationalId: jsonData[kNATIONALID],
    );
  }

  ChatUser get toChatUser {
    return ChatUser(
      id: id.toString(),
      firstName: username,
    );
  }
}
