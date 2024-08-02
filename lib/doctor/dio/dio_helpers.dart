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

  static Future<Response> cancelAppoinment(int appointmentId) async {
    return await dio.delete("${EndPoint.cancelAppointment}$appointmentId");
  }

  static Future<Response> getAllAvailableAssistants(int appointmentId) async {
    return await dio.get(
      EndPoint.getAllAvailabelAssistants,
      queryParameters: {
        kPROCESSID: appointmentId,
      },
    );
  }

  static Future<Response> decision(
      Map<String, dynamic> data, String token) async {
    return await dio.post(
      EndPoint.decision,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap(data),
    );
  }
  static Future<Response> updateDecision(
      Map<String, dynamic> data, String token) async {
    return await dio.post(
      EndPoint.updateDecision,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap(data),
    );
  }

  static Future<Response> addMark(
      Map<String, dynamic> data) async {
    return await dio.post(
      EndPoint.addMark,
      data: FormData.fromMap(data),
    );
  }

   static Future<Response> deleteMark(
      Map<String, dynamic> data) async {
    return await dio.post(
      EndPoint.deleteMark,
      data: FormData.fromMap(data),
    );
  }
}
