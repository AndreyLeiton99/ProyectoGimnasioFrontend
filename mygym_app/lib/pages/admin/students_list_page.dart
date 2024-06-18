import 'package:flutter/material.dart';
import '../../models/course_response/course_response.dart';
import '../../models/user_response/course_model.dart';
import '../../models/user_response/user_model.dart';

class StudentsListPage extends StatefulWidget {
  final CourseComplete course;
  final List<User> students;

  StudentsListPage({required this.course, required this.students});

  @override
  _StudentsListPageState createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  List<bool> attendanceList = []; // Lista de asistencia

  @override
  void initState() {
    super.initState();

    // Inicializar la lista de asistencia con el tamaño de la lista de estudiantes
    attendanceList = List<bool>.filled(widget.students.length, false);
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
      children: widget.students.asMap().entries.map((entry) {
        int index = entry.key;
        User student = entry.value;
        return _buildStudentCard(student, index);
      }).toList(),
    );
  }

  Widget _buildStudentCard(User student, int index) {
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
                  student.username,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: ${student.email}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Switch(
              value: attendanceList[index],
              onChanged: (value) {
                setState(() {
                  attendanceList[index] = value;
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
