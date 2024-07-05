import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel? loginInfo;
  ConnectionEnum? connecion;
  String? errorMessage;

  Future<void> logIn() async {
    connecion = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kUSERNAME: usernameController.text,
      kPASSWORD: passwordController.text
    };

    try {
      var response = await DioHelper.logIn(data);
      loginInfo = LoginModel.fromJson(response.data[kDATA]);
      CacheHelper().saveData(key: kTOKEN, value: loginInfo!.token);
      CacheHelper().saveData(key: kID, value: loginInfo!.id);

      connecion = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connecion = ConnectionEnum.failed;
      //print(e.response!.data[kMESSAGE][0]);
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }
}