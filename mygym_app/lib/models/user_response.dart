import 'dart:convert';

class User {
    final int id;
    final String username;
    final String email;
    final String provider;
    final bool confirmed;
    final bool blocked;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<Curso> cursos;
    final List<Asistencia> asistencias;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.provider,
        required this.confirmed,
        required this.blocked,
        required this.createdAt,
        required this.updatedAt,
        required this.cursos,
        required this.asistencias,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
        asistencias: List<Asistencia>.from(json["asistencias"].map((x) => Asistencia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
        "asistencias": List<dynamic>.from(asistencias.map((x) => x.toJson())),
    };
}

class Asistencia {
    final int id;
    final DateTime date;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;

    Asistencia({
        required this.id,
        required this.date,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
    });

    factory Asistencia.fromRawJson(String str) => Asistencia.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
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

class Curso {
    final int id;
    final String nombreCurso;
    final String description;
    final DateTime date;
    final int capacity;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;

    Curso({
        required this.id,
        required this.nombreCurso,
        required this.description,
        required this.date,
        required this.capacity,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
    });

    factory Curso.fromRawJson(String str) => Curso.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        id: json["id"],
        nombreCurso: json["nombreCurso"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        capacity: json["capacity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombreCurso": nombreCurso,
        "description": description,
        "date": date.toIso8601String(),
        "capacity": capacity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
    };
}
