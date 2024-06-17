import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response/course_model.dart';

import 'progress_painter.dart';

class CourseInfoCard extends StatelessWidget {
  const CourseInfoCard({super.key, required this.courses, required this.totalCourses});

final List<Course> courses;
final List<Course> totalCourses;

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
                    title: 'Matriculados',
                    number: courses.length.toString(),
                    gradientColors: [Colors.orange, Colors.orangeAccent],
                  ),
                  const SizedBox(width: 10),
                  _buildProgressCard(
                    title: 'Disponibles',
                    number: ((totalCourses.length) - (courses.length)).toString(),
                    gradientColors: [Colors.red, Colors.redAccent],
                  ),
                  const SizedBox(width: 10),
                  _buildProgressCard(
                    title: 'Congelados',
                    number: '0',
                    gradientColors: [Colors.purple, Colors.purpleAccent],
                  ),
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
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
            
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}