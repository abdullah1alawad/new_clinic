import 'package:clinic_test_app/common/core/utils/app_constants.dart';

class LoginModel {
  final String token;
  final int id;
  final String userRole;

  LoginModel({
    required this.token,
    required this.id,
    required this.userRole,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      token: jsonData[kTOKEN],
      id: jsonData[kID],
      userRole: jsonData[kUSERROLE],
    );
  }
}
