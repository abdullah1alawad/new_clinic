import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../common/model/user_model.dart';
import '../../../common/cache/cache_helper.dart';
import '../../../common/core/enum/connection_enum.dart';
import '../../../common/core/utils/app_constants.dart';
import '../../dio/dio_helpers.dart';

class UpdateDecisionProvider extends ChangeNotifier {
  int? assistantId, button;
  String assistantName = "";
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> updateDecision(int appointmentId, int choice) async {
    connection = ConnectionEnum.cunnecting;
    button = choice;
    notifyListeners();

    Map<String, dynamic> data = {
      kPROCESSID: appointmentId,
      kASSISTANTID: assistantId,
      kDECISION: choice,
    };
    print(data);

    try {
      var response = await DioHelper.updateDecision(
        data,
        CacheHelper().getData(key: kTOKEN),
      );

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      print(e.response!.data);
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }

  void choose(UserModel assistant) {
    assistantId = assistant.id;
    assistantName = assistant.name;
    notifyListeners();
  }
}
