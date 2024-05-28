import '/cache/cache_helper.dart';
import 'package:dio/dio.dart';
import '/core/utils/app_constants.dart';
import '/dio/end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
      headers: {
        "token": CacheHelper().getData(key: kTOKEN),
      },
    ),
  );

  // static Future<Response> signUp(Map<String, dynamic> data) async {
  //   return await dio.post(EndPoint.signup, data: FormData.fromMap(data));
  // }

  static Future<Response> logIn(Map<String, dynamic> data) async {
    return await dio.post(EndPoint.login, data: FormData.fromMap(data));
  }

  // static Future<Response> getUserInfo() async {
  //   return await dio.get(EndPoint.getUserDataEndPoint(
  //       CacheHelper().getData(key: AppStrings.id)));
  // }
}
