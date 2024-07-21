import 'package:clinic_test_app/core/utils/app_constants.dart';
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

//////////////////// auth ////////////////////////////

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

  static Future<Response> getAllUsers(String token) async {
    return await dio.get(
      EndPoint.getAllUsers,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

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

  //////////////////// chat ///////////////////////////////////

  static Future<Response> createChat(
      Map<String, dynamic> data, String token) async {
    return await dio.post(
      EndPoint.createChat,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap(data),
    );
  }

  static Future<Response> getSingleChat(int chatId, String token) async {
    return await dio.get(
      "${EndPoint.getSingleChat}$chatId",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  static Future<Response> getManyChats(String token) async {
    return await dio.get(
      EndPoint.getManyChats,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  static Future<Response> createMessage(
    Map<String, dynamic> data,
    String token,
  ) async {
    return await dio.post(
      EndPoint.createMessage,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: FormData.fromMap(data),
    );
  }

  static Future<Response> getChatMessages(int chatId, int page) async {
    return await dio.get(
      EndPoint.getChatMessages,
      queryParameters: {
        kCHATID: chatId,
        kPAGE: page,
      },
    );
  }

  /////////////////////// chat ///////////////////////////////////
}
