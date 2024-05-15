class UserModel {
  final String profilePic;
  final String email;
  final String phone;
  final String name;
  final Map<String, dynamic> address;

  UserModel(
      {required this.profilePic,
      required this.email,
      required this.phone,
      required this.name,
      required this.address});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        profilePic: jsonData['profilePic'],
        email: jsonData['email'],
        phone: jsonData['phone'],
        name: jsonData['name'],
        address: jsonData['location']);
  }
}
