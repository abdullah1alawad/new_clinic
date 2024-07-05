import 'package:clinic_test_app/core/utils/app_constants.dart';

class ClinicModel {
  final int id;
  final String name;
  //final String? photo;

  ClinicModel({
    required this.id,
    required this.name,
    //this.photo,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> jsonData) {
    return ClinicModel(
      id: jsonData[kID],
      name: jsonData[kNAME],
    );
  }
}
