import '../../../common/core/utils/app_constants.dart';
import '../../../common/model/user_model.dart';

class NotificationDataModel {
  final int processId;
  final String message, cause;
  final UserModel user;

  NotificationDataModel({
    required this.processId,
    required this.message,
    required this.user,
    required this.cause,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> jsonData) {
    return NotificationDataModel(
      processId: jsonData[kPROCESSID],
      message: jsonData[kMESSAGE],
      cause: jsonData[kCAUSE],
      user: UserModel.fromJson(jsonData[kUSER]),
    );
  }
}
