import 'package:clinic_test_app/common/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class QuestionsModel {
  final int id, clinicId;
  final String question, validation;
  final bool isNull;
  TextEditingController answer = TextEditingController();

  QuestionsModel({
    required this.id,
    required this.clinicId,
    required this.question,
    required this.validation,
    required this.isNull,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> jsonData) {
    return QuestionsModel(
      id: jsonData[kID],
      clinicId: jsonData[kCLINICID],
      question: jsonData[kQUESTION],
      validation: jsonData[kVALIDATION],
      isNull: jsonData[kISNULL],
    );
  }
}
