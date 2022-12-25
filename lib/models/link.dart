import 'dart:convert';

class Link {
  String? id;
  String courseId;
  String url;
  String description;
  Link({
    this.id,
    required this.courseId,
    required this.url,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'url': url,
      'description': description,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      id: map['id'],
      courseId: map['courseId'] ?? '',
      url: map['url'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Link.fromJson(String source) => Link.fromMap(json.decode(source));
}
