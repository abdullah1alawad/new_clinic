import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:clinic_test_app/student/model/appointment_model.dart';

class MarkModel {
  final String subjectName;
  final int mark;
  final List<AppointmentModel> appointments;

  MarkModel({
    required this.subjectName,
    required this.mark,
    required this.appointments,
  });

  factory MarkModel.fromjson(Map<String, dynamic> jsonData) {
    return MarkModel(
      subjectName: jsonData[kSUBJECTNAME],
      mark: jsonData[kMARK],
      appointments: (jsonData[kAPPOINTMENTS] as List)
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .toList(),
    );
  }
}
