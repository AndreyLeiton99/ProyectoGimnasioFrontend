import 'dart:convert';

import 'user_model.dart';

class VerifiedUser {
    final String jwt;
    final User user;

    VerifiedUser({
        required this.jwt,
        required this.user,
    });

    factory VerifiedUser.fromRawJson(String str) => VerifiedUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VerifiedUser.fromJson(Map<String, dynamic> json) => VerifiedUser(
        jwt: json["jwt"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user.toJson(),
    };
}

class Usuario {
    final int id;
    final String username;
    final String email;
    final String provider;
    final bool confirmed;
    final bool blocked;
    final DateTime createdAt;
    final DateTime updatedAt;

    Usuario({
        required this.id,
        required this.username,
        required this.email,
        required this.provider,
        required this.confirmed,
        required this.blocked,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
    };
}
