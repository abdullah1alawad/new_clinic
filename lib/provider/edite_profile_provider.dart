import 'package:clinic_test_app/cache/cache_helper.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/core/utils/app_services.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditeProfileProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  int? gender;
  XFile? photo;
  ConnectionEnum? connecion;
  String? errorMessage;

  Future<void> editeProfile() async {
    connecion = ConnectionEnum.cunnecting;
    notifyListeners();

    Map<String, dynamic> data = {
      kUSERNAME: usernameController.text,
      kNAME: nameController.text,
      kEMAIL: emailController.text,
      kNATIONALID: nationalIdController.text,
      kGENDER: gender,
      kPHONE: phoneController.text,
      kPHOTO: await uploadImageToAPI(photo!),
    };

    try {
      var response = await DioHelper.editeProfile(
          data, CacheHelper().getData(key: kTOKEN));
      connecion = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connecion = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }

  uploadProfilePhoto(XFile image) {
    photo = image;
    notifyListeners();
  }

  toggleGender(value) {
    gender = value;
    notifyListeners();
  }
}
