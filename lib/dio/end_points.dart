class EndPoint {
  static const String mobile = '10.0.2.2';
  static const String win = '127.0.0.1';

  static const String baseUrl = 'http://$win:8000/api/';
  static const String login = 'login';
  static const String editeProfile = 'user/update';
  static const String resetPassword = 'user/reset-password';
  static const String getFiveScreen = 'student/configuration';
  static const String getClinics = 'process/get-clinics';
  static const String getClinicInfo = 'process/get-info/';
  static const String getChairs = 'process/get-chairs/';
  static const String bookApointment = 'process/book-chair';
  static const String cancelAppointment = 'process/delete-process/';
  static const String searchForPatient = 'process/search-patient';
}
