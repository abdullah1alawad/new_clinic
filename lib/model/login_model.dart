import '../core/utils/app_constants.dart';

class LoginModel {
  final String message, token;

  LoginModel({required this.message, required this.token});

  factory LoginModel.fromjson(Map<String, dynamic> jsonData) {
    return LoginModel(
        message: jsonData[AppStrings.message],
        token: jsonData[AppStrings.token]);
  }
}
