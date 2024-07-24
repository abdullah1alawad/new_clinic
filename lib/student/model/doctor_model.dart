import 'package:clinic_test_app/common/core/utils/app_constants.dart';

class DoctorModel {
  final int id;
  final String name;

  DoctorModel({
    required this.id,
    required this.name,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> jsonData) {
    return DoctorModel(
      id: jsonData[kID],
      name: jsonData[kNAME],
    );
  }
}
