import '../core/utils/app_constants.dart';

class PatientInfoModel {
  final int id;
  final String question, answer;

  PatientInfoModel({
    required this.id,
    required this.answer,
    required this.question,
  });

  factory PatientInfoModel.fromJson(Map<String, dynamic> jsonDdat) {
    return PatientInfoModel(
      id: jsonDdat[kID],
      answer: jsonDdat[kANSWER],
      question: jsonDdat[kQUESTION],
    );
  }
}
