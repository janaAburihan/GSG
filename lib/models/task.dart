import 'dart:convert';

class Task {
  String? id;
  String courseId;
  String description;
  String title;
  int mark;
  DateTime deadline;
  DateTime publishingTime;

  Task({
    this.id,
    required this.publishingTime,
    required this.courseId,
    required this.mark,
    required this.description,
    required this.title,
    required this.deadline,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'mark': mark,
      'description': description,
      'title': title,
      'deadline': deadline,
      'publishingTime': publishingTime
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      courseId: map['courseId'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      deadline: DateTime.parse(map['publishingTime'].toDate().toString()),
      mark: map['mark']?.toInt() ?? 0,
      publishingTime: DateTime.parse(map['publishingTime'].toDate().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
