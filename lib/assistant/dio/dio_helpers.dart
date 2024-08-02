import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: kBASEURL,
      connectTimeout: Duration(seconds: 10), // Connection timeout
    receiveTimeout: Duration(seconds: 10), // Receive timeout
    sendTimeout: Duration(seconds: 10),  
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

}
