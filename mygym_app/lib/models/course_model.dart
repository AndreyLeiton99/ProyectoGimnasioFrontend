import 'dart:convert';

class Course {
  final int id;
  final String courseName;
  final String description;
  final DateTime date;
  final int capacity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  Course({
    required this.id,
    required this.courseName,
    required this.description,
    required this.date,
    required this.capacity,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseName: json["nombreCourse"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        capacity: json["capacity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseName": courseName,
        "description": description,
        "date": date.toIso8601String(),
        "capacity": capacity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
      };
}
