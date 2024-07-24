import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:clinic_test_app/student/dio/end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: kBASEURL,
    ),
  );

//////////////////// auth ////////////////////////////

//////////////////// auth ////////////////////////////

  static Future<Response> getFiveScreen(String token) async {
    return await dio.get(EndPoint.getFiveScreen,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

//////////////////// Appointment booking //////////////////////////
  static Future<Response> getClinics() async {
    return await dio.get(EndPoint.getClinics);
  }

  static Future<Response> getClinicInfo(int clinicId) async {
    return await dio.get("${EndPoint.getClinicInfo}$clinicId");
  }

  static Future<Response> getChairs(int clinicId, int doctorId) async {
    return await dio.get("${EndPoint.getChairs}$doctorId/$clinicId");
  }

  static Future<Response> bookAppointment(
      Map<String, dynamic> data, String token) async {
    return await dio.post(EndPoint.bookApointment,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: data);
  }

  static Future<Response> cancelAppoinment(int appointmentId) async {
    return await dio.delete("${EndPoint.cancelAppointment}$appointmentId");
  }

  static Future<Response> searchForPatient(
    int clinicId,
    String? natId,
    String token,
  ) async {
    return await dio.get(
      EndPoint.searchForPatient,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      queryParameters: {
        kNATIONALID: natId,
        kCLINICID: clinicId,
      },
    );
  }

  //////////////////// Appointment booking //////////////////////////
}
