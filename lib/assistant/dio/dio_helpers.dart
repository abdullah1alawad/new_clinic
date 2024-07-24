import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: kBASEURL,
    ),
  );

//////////////////// auth ////////////////////////////


//////////////////// auth ////////////////////////////

  static Future<Response> getInitScreens(String token) async {
    return await dio.get(
      EndPoint.getInitScreens,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  static Future<Response> cancelAppoinment(int appointmentId) async {
    return await dio.delete("${EndPoint.cancelAppointment}$appointmentId");
  }
}
