import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/core/enum/connection_enum.dart';
import '../../../common/core/utils/app_constants.dart';
import '../../dio/dio_helpers.dart';

class DeleteMarkProvider extends ChangeNotifier {
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> deleteMark(int markId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    print(markId);
    Map<String, dynamic> data = {
      '$kSUBPROCESSID[0]': markId,
    };

    try {
      var response = await DioHelper.deleteMark(data);

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      print(e.response!.data);
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
