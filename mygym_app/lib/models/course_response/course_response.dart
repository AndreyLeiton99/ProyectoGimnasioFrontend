import 'dart:convert';

class CursoResponse {
    final List<CourseData> data;
    final Meta meta;

    CursoResponse({
        required this.data,
        required this.meta,
    });

    factory CursoResponse.fromRawJson(String str) => CursoResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CursoResponse.fromJson(Map<String, dynamic> json) => CursoResponse(
        data: List<CourseData>.from(json["data"].map((x) => CourseData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class CourseData {
    final int id;
    final CourseAttributes attributes;

    CourseData({
        required this.id,
        required this.attributes,
    });

    factory CourseData.fromRawJson(String str) => CourseData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        id: json["id"],
        attributes: CourseAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class CourseAttributes {
    final String nombreCurso;
    final String description;
    final DateTime date;
    final int capacity;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;

    CourseAttributes({
        required this.nombreCurso,
        required this.description,
        required this.date,
        required this.capacity,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
    });

    factory CourseAttributes.fromRawJson(String str) => CourseAttributes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CourseAttributes.fromJson(Map<String, dynamic> json) => CourseAttributes(
        nombreCurso: json["nombreCurso"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        capacity: json["capacity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "nombreCurso": nombreCurso,
        "description": description,
        "date": date.toIso8601String(),
        "capacity": capacity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
    };
}

class Meta {
    final Pagination pagination;

    Meta({
        required this.pagination,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
    };
}

class Pagination {
    final int page;
    final int pageSize;
    final int pageCount;
    final int total;

    Pagination({
        required this.page,
        required this.pageSize,
        required this.pageCount,
        required this.total,
    });

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
