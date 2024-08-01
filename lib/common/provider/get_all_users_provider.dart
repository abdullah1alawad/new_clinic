import '../cache/cache_helper.dart';
import '../core/enum/connection_enum.dart';
import '../core/utils/app_constants.dart';
import '../dio/dio_helpers.dart';
import '../model/user_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GetAllUsersProvider extends ChangeNotifier {
  List<UserModel> users = [];
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getAllUser() async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response =
          await DioHelper.getAllUsers(CacheHelper().getData(key: kTOKEN));

      users = (response.data[kDATA] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}