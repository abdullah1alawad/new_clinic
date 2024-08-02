import '../../../common/core/utils/app_constants.dart';

import 'notification_data_model.dart';

class NotificationModel {
  final String id;
  final NotificationDataModel data;
  String? readAt;
  final String createdAt, updatedAt;

  NotificationModel({
    required this.id,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> jsonData) {
    return NotificationModel(
      id: jsonData[kID],
      data: NotificationDataModel.fromJson(jsonData[kDATA]),
      readAt: jsonData[kREADAT],
      createdAt: jsonData[kCREATEDAT],
      updatedAt: jsonData[kUPDATEDAT],
    );
  }
}
