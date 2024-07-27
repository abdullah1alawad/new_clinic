import '../../common/core/utils/app_constants.dart';
import '../../common/model/patient_info_model.dart';
import 'subprocess_model.dart';

class AppointmentModel {
  final String studentName,
      assistentName,
      subjectName,
      clinicName,
      date,
      timeDifference;
  String? photo;
  final int chairNumber, status, id;
  final int? mark;
  final List<SubprocessModel> subprocesses;
  final List<PatientInfoModel> patientInfo;

  AppointmentModel({
    required this.studentName,
    required this.assistentName,
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
    required this.patientInfo,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> jsonData) {
    return AppointmentModel(
      studentName: jsonData[kSTUDENTNAME],
      assistentName: jsonData[kASSISTENTNAME],
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
      patientInfo: (jsonData[kPATIENTINFO] as List)
          .map((question) => PatientInfoModel.fromJson(question))
          .toList(),
    );
  }
}
