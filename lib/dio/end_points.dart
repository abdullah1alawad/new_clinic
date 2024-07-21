class EndPoint {
  static const String mobile = '10.0.2.2';
  static const String win = '127.0.0.1';

  static const String baseUrl = 'http://$win:8000/api/';

  static const String login = 'login';
  static const String editeProfile = 'user/update';
  static const String resetPassword = 'user/reset-password';
  static const String getAllUsers = 'user';

  static const String getFiveScreen = 'student/configuration';

  static const String getClinics = 'process/get-clinics';
  static const String getClinicInfo = 'process/get-info/';
  static const String getChairs = 'process/get-chairs/';
  static const String bookApointment = 'process/book-chair';
  static const String cancelAppointment = 'process/delete-process/';
  static const String searchForPatient = 'process/search-patient';

  static const String createChat = 'chat';
  static const String getSingleChat = 'chat/';
  static const String getManyChats = 'chat';
  static const String createMessage = 'chat_message';
  static const String getChatMessages = 'chat_message';
}
