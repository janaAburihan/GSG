import 'dart:convert';

import 'package:gsg_app/admin/models/participent.dart';

class Attendence {
  String? id;
  String courseId;
  DateTime? publishingTime = DateTime.now();
  Map<AppUser, bool>? submitions;
  Attendence(
      {this.id, required this.courseId, this.publishingTime, this.submitions});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'publishingTime': publishingTime,
      'submitions': submitions,
    };
  }

  factory Attendence.fromMap(Map<String, dynamic> map) {
    return Attendence(
      id: map['id'],
      publishingTime: DateTime.parse(map['publishingTime'].toDate().toString()),
      courseId: map['courseId'] ?? '',
      submitions: map['submitions'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendence.fromJson(String source) =>
      Attendence.fromMap(json.decode(source));
}
