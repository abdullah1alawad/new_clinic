import 'package:clinic_test_app/common/core/utils/app_constants.dart';

class SubprocessModel {
  final int id, mark;
  final String name;

  SubprocessModel({
    required this.id,
    required this.mark,
    required this.name,
  });

  factory SubprocessModel.fromJson(Map<String, dynamic> jsonData) {
    return SubprocessModel(
      id: jsonData[kID],
      mark: jsonData[kMARK],
      name: jsonData[kNAME],
    );
  }
}
