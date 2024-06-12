import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/model/subprocess_model.dart';

class CompletedAppointmentModel {
  final String doctorName,
      assistenName,
      patientName,
      subjectName,
      clinicName,
      photo,
      date,
      timeDifference;
  final int chairNumber, status, mark, id;
  final List<SubprocessModel> subprocesses;

  CompletedAppointmentModel({
    required this.doctorName,
    required this.assistenName,
    required this.patientName,
    required this.subjectName,
    required this.clinicName,
    required this.photo,
    required this.date,
    required this.chairNumber,
    required this.status,
    required this.mark,
    required this.id,
    required this.timeDifference,
    required this.subprocesses,
  });

  factory CompletedAppointmentModel.fromJson(Map<String, dynamic> jsonData) {
    return CompletedAppointmentModel(
      doctorName: jsonData[kDOCTORNAME],
      assistenName: jsonData[kASSISTENTNAME],
      patientName: jsonData[kPATINENTNAME],
      subjectName: jsonData[kSUBJECTNAME],
      clinicName: jsonData[kCLINICNAME],
      photo: jsonData[kPHOTO],
      date: jsonData[kAPPOINTMENTDATE],
      chairNumber: jsonData[kCHAIRNUMBER],
      status: jsonData[kSTATUS],
      mark: jsonData[kMARK],
      id: jsonData[kID],
      timeDifference: jsonData[kTIMEDIFFERENCE],
      subprocesses: (jsonData[kSUBPROCESSES] as List)
          .map((subprocess) => SubprocessModel.fromJson(subprocess))
          .toList(),
    );
  }
}
