import 'package:clinic_test_app/core/utils/app_constants.dart';

class MarkModel {
  final String subjectName;
  final int mark;

  MarkModel({
    required this.subjectName,
    required this.mark,
  });

  factory MarkModel.fromjson(Map<String, dynamic> jsonData) {
    return MarkModel(
      subjectName: jsonData[kSUBJECTNAME],
      mark: jsonData[kMARK],
    );
  }
}
