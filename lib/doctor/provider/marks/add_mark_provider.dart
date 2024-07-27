import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/core/enum/connection_enum.dart';
import '../../../common/core/utils/app_constants.dart';
import '../../model/subprocess_model.dart';
import '../../dio/dio_helpers.dart';

class AddMarkProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController mark = TextEditingController();
  SubprocessModel? subprocess;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> addMark(int appointmentId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kPROCESSID: appointmentId,
      '$kNAME[0]': name.text,
      '$kMARK[0]': mark.text,
    };

    try {
      var response = await DioHelper.addMark(data);
      subprocess = SubprocessModel.fromJson(response.data[kDATA][0]);

      name.text = "";
      mark.text = "";
      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE];
      notifyListeners();
    }
  }
}
