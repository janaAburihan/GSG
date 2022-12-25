import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String courseId;
  String userName;
  String phoneNumber;
  bool isTrainer;
  AppUser({
    required this.email,
    this.id,
    required this.courseId,
    required this.userName,
    required this.phoneNumber,
    this.isTrainer = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'courseId': courseId,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'isTrainer': isTrainer,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  AppUser copyWith({
    String? email,
    String? id,
    String? courseId,
    String? userName,
    String? phoneNumber,
    bool? isTrainer,
  }) {
    return AppUser(
      email: email ?? this.email,
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isTrainer: isTrainer ?? this.isTrainer,
    );
  }

  @override
  String toString() {
    return 'AppUser(email: $email, id: $id, courseId: $courseId, userName: $userName, phoneNumber: $phoneNumber, isTrainer: $isTrainer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppUser &&
      other.email == email &&
      other.id == id &&
      other.courseId == courseId &&
      other.userName == userName &&
      other.phoneNumber == phoneNumber &&
      other.isTrainer == isTrainer;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      id.hashCode ^
      courseId.hashCode ^
      userName.hashCode ^
      phoneNumber.hashCode ^
      isTrainer.hashCode;
  }
}
