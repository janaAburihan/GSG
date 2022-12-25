import 'dart:convert';

class Attendence {
  String? id;
  String courseId;
  DateTime? publishingTime = DateTime.now();
  Attendence({
    this.id,
    required this.courseId,
    this.publishingTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'publishingTime': publishingTime,
    };
  }

  factory Attendence.fromMap(Map<String, dynamic> map) {
    return Attendence(
      id: map['id'],
      publishingTime: DateTime.parse(map['publishingTime'].toDate().toString()),
      courseId: map['courseId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendence.fromJson(String source) =>
      Attendence.fromMap(json.decode(source));
}
