import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/dio/dio_helpers.dart';
import 'package:clinic_test_app/model/doctor_model.dart';
import 'package:clinic_test_app/model/question_model.dart';
import 'package:clinic_test_app/model/subject_model.dart';
import 'package:clinic_test_app/widgets/patient_question_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClinicInfoProvider extends ChangeNotifier {
  List<QuestionsModel>? questions;
  List<Column> processedQuestions = [];
  List<SubjectModel>? subjects;
  List<DoctorModel>? doctors;
  ConnectionEnum? connection;
  String? errorMessage;

  Future<void> getClinicInfo(int clinicId) async {
    connection = ConnectionEnum.cunnecting;
    notifyListeners();

    try {
      var response = await DioHelper.getClinicInfo(clinicId);

      questions = (response.data[kDATA][kQUESTIONS] as List)
          .map((question) => QuestionsModel.fromJson(question))
          .toList();
      processQuestion();

      subjects = (response.data[kDATA][kSUBJECTS] as List)
          .map((subject) => SubjectModel.fromJson(subject))
          .toList();

      doctors = (response.data[kDATA][kDOCTORS] as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList();

      connection = ConnectionEnum.connected;
      notifyListeners();
    } on DioException catch (e) {
      connection = ConnectionEnum.failed;
      errorMessage = e.response!.data[kMESSAGE][0];
      notifyListeners();
    }
  }

  void processQuestion() {
    int size = questions!.length;
    processedQuestions = [];

    for (int i = 0; i < size; i += 5) {
      List<PatientQuestionTextField> temp = [];
      for (int j = i; j < i + 5 && j < size; j++) {
        temp.add(
          PatientQuestionTextField(
            label: questions![j].question,
            icon: Icons.question_mark,
            controller: questions![j].answer,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء الاجابة عن السؤال';
              }
              return null;
            },
            obscureText: false,
          ),
        );
      }
      processedQuestions.add(Column(children: temp));
    }
  }
}
