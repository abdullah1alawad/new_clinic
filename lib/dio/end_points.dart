class EndPoint {
  static String signup = 'user/signup';
  static String login = 'user/signin';
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}
