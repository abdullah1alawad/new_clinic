import 'package:clinic_test_app/core/utils/app_constants.dart';

class SubjectModel {
  final int id, clinicId;
  final String name;

  SubjectModel({
    required this.id,
    required this.clinicId,
    required this.name,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> jsonData) {
    return SubjectModel(
      id: jsonData[kID],
      clinicId: jsonData[kCLINICID],
      name: jsonData[kNAME],
    );
  }
}
