import 'dart:convert';
import '../admin/models/participent.dart';

class Task {
  String? id;
  String courseId;
  String description;
  String title;
  DateTime deadline;
  DateTime publishingTime;
  Map<AppUser, String>? submitions;

  Task({
    this.id,
    required this.publishingTime,
    required this.courseId,
    required this.description,
    required this.title,
    required this.deadline,
    this.submitions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'description': description,
      'title': title,
      'deadline': deadline,
      'publishingTime': publishingTime,
      'submitions': submitions,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      courseId: map['courseId'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      deadline: DateTime.parse(map['publishingTime'].toDate().toString()),
      publishingTime: DateTime.parse(map['publishingTime'].toDate().toString()),
      submitions: map['submitions'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
