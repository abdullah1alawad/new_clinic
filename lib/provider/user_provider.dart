// import '/cache/cache_helper.dart';
// import '/core/utils/app_constants.dart';
// import '/core/utils/app_services.dart';
// import '/model/user_model.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import '/dio/dio_helpers.dart';
// import '/model/login_model.dart';
// import '/core/enum/connection_enum.dart';

// class UserProvider extends ChangeNotifier {
//   TextEditingController loginEmailControler = TextEditingController();
//   TextEditingController loginPasswordControler = TextEditingController();
//   LoginModel? userLogin;
//   ConnectionEnum? loginCunnecion;
//   String? loginErrorMessage;

//   TextEditingController signupEmailControler = TextEditingController();
//   TextEditingController signupPasswordControler = TextEditingController();
//   TextEditingController signupNameControler = TextEditingController();
//   TextEditingController signupPhoneControler = TextEditingController();
//   TextEditingController signupConfirmPasswordControler =
//       TextEditingController();
//   TextEditingController signupLocationControler = TextEditingController();
//   XFile? profilepic;
//   ConnectionEnum? signupCunnecion;
//   String? signupErrorMessage;

//   ConnectionEnum? getInfoCunnecion;
//   UserModel? userInfo;
//   String? getInfoErrorMessage;

//   Future<void> logIn() async {
//     loginCunnecion = ConnectionEnum.cunnecting;
//     notifyListeners();

//     Map<String, dynamic> data = {
//       'email': loginEmailControler.text,
//       'password': loginPasswordControler.text
//     };

//     try {
//       var response = await DioHelper.logIn(data);
//       userLogin = LoginModel.fromjson(response.data);
//       final decodedToken = JwtDecoder.decode(userLogin!.token);
//       CacheHelper().saveData(key: AppStrings.token, value: userLogin!.token);
//       CacheHelper().saveData(key: AppStrings.id, value: decodedToken['id']);

//       loginCunnecion = ConnectionEnum.connected;
//       notifyListeners();
//     } on DioException catch (e) {
//       loginCunnecion = ConnectionEnum.failed;
//       loginErrorMessage = e.response!.data['ErrorMessage'];
//       notifyListeners();
//     }
//   }

//   Future<void> signUp() async {
//     signupCunnecion = ConnectionEnum.cunnecting;
//     notifyListeners();

//     Map<String, dynamic> data = {
//       'email': signupEmailControler.text,
//       'password': signupPasswordControler.text,
//       'phone': signupPhoneControler.text,
//       'name': signupNameControler.text,
//       'confirmPassword': signupConfirmPasswordControler.text,
//       'location':
//           '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
//       'profilePic': await uploadImageToAPI(profilepic!)
//     };

//     try {
//       var response = await DioHelper.signUp(data);
//       signupCunnecion = ConnectionEnum.connected;
//       notifyListeners();
//     } on DioException catch (e) {
//       signupCunnecion = ConnectionEnum.failed;
//       signupErrorMessage = e.response!.data['ErrorMessage'];
//       notifyListeners();
//     }
//   }

//   Future<void> getUserInfo() async {
//     getInfoCunnecion = ConnectionEnum.cunnecting;
//     notifyListeners();

//     try {
//       var response = await DioHelper.getUserInfo();
//       userInfo = UserModel.fromJson(response.data['user']);
//       getInfoCunnecion = ConnectionEnum.connected;
//       notifyListeners();
//     } on DioException catch (e) {
//       getInfoCunnecion = ConnectionEnum.failed;
//       getInfoErrorMessage = e.response!.data['ErrorMessage'];
//       notifyListeners();
//     }
//   }

//   uploadProfilePic(XFile image) {
//     profilepic = image;
//     notifyListeners();
//   }
// }
