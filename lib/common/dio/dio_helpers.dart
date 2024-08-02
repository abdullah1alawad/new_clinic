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

//////////////////// auth ////////////////////////////

  static Future<Response> getAllUsers(String token) async {
    return await dio.get(
      EndPoint.getAllUsers,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

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
    String socketId,
  ) async {
    return await dio.post(
      EndPoint.createMessage,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'X-Socket-ID': socketId,
      }),
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

  static Future<Response> makeChatRead(int chatId, String token) async {
    return await dio.put(
      EndPoint.makeChatRead,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {
        kCHATID: chatId,
      },
    );
  }

  /////////////////////// chat ///////////////////////////////////

  static Future<Response> makeNotificationRead(
      String notificationId, String token) async {
    return await dio.put(
      EndPoint.makeNotificationRead,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {
        kNOTIFICATIONID: notificationId,
      },
    );
  }
}
