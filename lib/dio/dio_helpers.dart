import 'package:dio/dio.dart';
import '/dio/end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
      // headers: {
      //   //"token": CacheHelper().getData(key: kTOKEN),
      //   'Authorization': 'Bearer ${CacheHelper().getData(key: kTOKEN)}',
      // },
    ),
  );

  // static Future<Response> signUp(Map<String, dynamic> data) async {
  //   return await dio.post(EndPoint.signup, data: FormData.fromMap(data));
  // }

  static Future<Response> logIn(Map<String, dynamic> data) async {
    return await dio.post(EndPoint.login, data: FormData.fromMap(data));
  }

  static Future<Response> editeProfile(
      Map<String, dynamic> data, String token) async {
    return await dio.post(EndPoint.editeProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: FormData.fromMap(data));
  }

  static Future<Response> resetPassword(
      Map<String, dynamic> data, String token) async {
    return await dio.put(EndPoint.resetPassword,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: data);
  }

  static Future<Response> getFiveScreen(String token) async {
    return await dio.get(EndPoint.getFiveScreen,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }

  static Future<Response> getClinics() async {
    return await dio.get(EndPoint.getClinics);
  }

  static Future<Response> getClinicInfo(int clinicId) async {
    return await dio.get("${EndPoint.getClinicInfo}$clinicId");
  }

  static Future<Response> getChairs(int clinicId, int doctorId) async {
    return await dio.get("${EndPoint.getChairs}$doctorId/$clinicId");
  }

  // static Future<Response> getUserInfo() async {
  //   return await dio.get(EndPoint.getUserDataEndPoint(
  //       CacheHelper().getData(key: AppStrings.id)));
  // }
}
