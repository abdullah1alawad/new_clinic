import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> resetPassword() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kOLDPASSWORD: oldPasswordController.text,
      kNEWPASSWORD: newPasswordController.text,
      kCONFIRMPASSWORD: confirmPasswordController.text
    };

    try {
      var response = await DioHelper.resetPassword(
          data, CacheHelper().getData(key: kTOKEN));

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }
}
