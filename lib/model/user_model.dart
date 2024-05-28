import 'package:clinic_test_app/core/utils/app_constants.dart';

class UserModel {
  final String token;
  final int id;
  final String? photo;
  final String email, userName;
  final String name, gender;
  final String phone, nationalId;

  UserModel({
    required this.token,
    required this.id,
    required this.photo,
    required this.email,
    required this.userName,
    required this.name,
    required this.gender,
    required this.phone,
    required this.nationalId,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      token: jsonData[kTOKEN],
      id: jsonData[kID],
      photo: jsonData[kPHOTO],
      email: jsonData[kEMAIL],
      userName: jsonData[kUSERNAME],
      name: jsonData[kNAME],
      gender: jsonData[kGENDER],
      phone: jsonData[kPHONE],
      nationalId: jsonData[kNATIONALID],
    );
  }
}
