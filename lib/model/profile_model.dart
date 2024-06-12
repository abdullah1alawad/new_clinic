import 'package:clinic_test_app/core/utils/app_constants.dart';

class ProfileModel {
  final String email, username, name, gender, phone, photo, nationalId;

  ProfileModel({
    required this.email,
    required this.username,
    required this.name,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.nationalId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      email: jsonData[kEMAIL],
      username: jsonData[kUSERNAME],
      name: jsonData[kNAME],
      gender: jsonData[kGENDER],
      phone: jsonData[kPHONE],
      photo: jsonData[kPHOTO],
      nationalId: jsonData[kNATIONALID],
    );
  }
}
