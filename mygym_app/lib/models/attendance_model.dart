import 'dart:convert';

class Attendance {
  final int id;
  final DateTime date;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;

  Attendance({
    required this.id,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory Attendance.fromRawJson(String str) =>
      Attendance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
      };
}
