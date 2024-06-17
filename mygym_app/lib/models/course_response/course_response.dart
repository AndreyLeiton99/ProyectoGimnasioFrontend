class Student {
  final int id;
  final String username;
  final String email;

  Student({required this.id, required this.username, required this.email});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      username: json['attributes']['username'],
      email: json['attributes']['email'],
    );
  }
}

class Attendance {
  final int id;
  final String date;
  final String status;

  Attendance({required this.id, required this.date, required this.status});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      date: json['attributes']['date'],
      status: json['attributes']['status'],
    );
  }
}

class Professor {
  final int id;
  final String username;
  final String email;

  Professor({required this.id, required this.username, required this.email});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      id: json['id'],
      username: json['attributes']['username'],
      email: json['attributes']['email'],
    );
  }
}

class CourseComplete {
  final int id;
  final String nombreCurso;
  final String description;
  final DateTime date;
  final int capacity;
  final String createdAt;
  final String updatedAt;
  final Professor professor;
  final List<Student> students;
  final List<Attendance> attendances;

  CourseComplete({
    required this.id,
    required this.nombreCurso,
    required this.description,
    required this.date,
    required this.capacity,
    required this.createdAt,
    required this.updatedAt,
    required this.professor,
    required this.students,
    required this.attendances,
  });

  factory CourseComplete.fromJson(Map<String, dynamic> json) {
    var studentsJson = json['attributes']['students']['data'] as List;
    var attendancesJson = json['attributes']['asistencias']['data'] as List;

    List<Student> studentsList = studentsJson.map((i) => Student.fromJson(i)).toList();
    List<Attendance> attendancesList = attendancesJson.map((i) => Attendance.fromJson(i)).toList();

    return CourseComplete(
      id: json['id'],
      nombreCurso: json['attributes']['nombreCurso'],
      description: json['attributes']['description'],
      date: DateTime.parse(json['attributes']['date']),
      capacity: json['attributes']['capacity'],
      createdAt: json['attributes']['createdAt'],
      updatedAt: json['attributes']['updatedAt'],
      professor: Professor.fromJson(json['attributes']['professor']['data']),
      students: studentsList,
      attendances: attendancesList,
    );
  }
}
