import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String courseId;
  String userName;
  String phoneNumber;
  String password;
  bool isTrainer;
  AppUser({
    required this.email,
    this.id,
    required this.courseId,
    required this.userName,
    required this.phoneNumber,
    this.isTrainer = false,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'courseId': courseId,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'isTrainer': isTrainer,
      'password': password,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        email: map['email'] ?? '',
        id: map['id'],
        courseId: map['courseId'] ?? '',
        userName: map['userName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        isTrainer: map['isTrainer'] ?? false,
        password: map['password'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
