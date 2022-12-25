import 'dart:convert';

class Course {
  String? id;
  String imageUrl;
  String name;
  Course({required this.imageUrl, required this.name, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'imageUrl': imageUrl,
      'name': name,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));
}
