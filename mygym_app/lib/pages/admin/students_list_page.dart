import 'package:flutter/material.dart';
import '../../models/course_response/course_response.dart';
import '../../models/user_response/course_model.dart';

class StudentsListPage extends StatefulWidget {
  final CourseComplete course;

  StudentsListPage({required this.course});

  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  List<Student> students =
      []; // Lista de estudiantes, debe ser populada según tu lógica

  @override
  void initState() {
    super.initState();

    //TODO: Cargar lista de estudiantes
    students = List.generate(
      10,
      (index) => Student(
        id: index + 1,
        name: 'Estudiante ${index + 1}',
        age: 20 + index,
        attendance: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes de ${widget.course.nombreCurso}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseInfoCard(widget.course),
            const SizedBox(height: 20),
            _buildStudentsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfoCard(CourseComplete course) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.nombreCurso,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              'Día: ${getDayName(course.date.weekday)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Hora: ${TimeOfDay.fromDateTime(course.date).format(context)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              course.description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: students.map((student) => _buildStudentCard(student)).toList(),
    );
  }

  Widget _buildStudentCard(Student student) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Edad: ${student.age}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Switch(
              value: student.attendance,
              onChanged: (value) {
                setState(() {
                  student.attendance = value;
                });
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Día desconocido';
    }
  }
}

class Student {
  final int id;
  final String name;
  final int age;
  bool attendance;

  Student({
    required this.id,
    required this.name,
    required this.age,
    this.attendance = false,
  });
}
