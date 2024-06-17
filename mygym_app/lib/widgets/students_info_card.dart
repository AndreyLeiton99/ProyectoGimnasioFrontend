import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response/course_model.dart';

import 'progress_painter.dart';

class StudentInfoCard extends StatelessWidget {
  const StudentInfoCard({super.key, required this.totalStudents, required this.totalCourses});

final int totalStudents;
final int totalCourses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProgressCard(
                    title: 'Estudiantes',
                    number: totalStudents.toString(),
                    gradientColors: [Colors.orange, Colors.orangeAccent],
                  ),
                  const SizedBox(width: 10),
                  _buildProgressCard(
                    title: 'Cursos',
                    number: totalCourses.toString(),
                    gradientColors: [Colors.red, Colors.redAccent],
                  ),
                  const SizedBox(width: 10),
                  // _buildProgressCard(
                  //   title: 'Congelados',
                  //   number: '0',
                  //   gradientColors: [Colors.purple, Colors.purpleAccent],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String number,
    required List<Color> gradientColors,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: CustomPaint(
                painter: ProgressPainter(
                  progress: 1, // Aquí deberías ajustar el progreso según tu lógica
                  gradientColors: gradientColors,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              number,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
            
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}