import 'package:clinic_test_app/core/utils/app_constants.dart';

class ComingAppointmentModel {
  final String doctorName,
      assistenName,
      patientName,
      subjectName,
      clinicName,
      photo,
      date,
      timeDifference;
  final int chairNumber, status, id;
  final int? mark;

  ComingAppointmentModel({
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
  });

  factory ComingAppointmentModel.fromJson(Map<String, dynamic> jsonData) {
    return ComingAppointmentModel(
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
    );
  }
}
