import 'package:clinic_test_app/core/utils/app_constants.dart';

class LoginModel {
  final String token;
  final int id;

  LoginModel({
    required this.token,
    required this.id,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      token: jsonData[kTOKEN],
      id: jsonData[kID],
    );
  }
}
