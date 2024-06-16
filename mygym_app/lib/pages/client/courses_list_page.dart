import 'package:flutter/material.dart';

import '../../models/user_response.dart';

class ListViewCoursesPage extends StatelessWidget {
  final List<Curso> cursos;

  ListViewCoursesPage({required this.cursos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los cursos'),
      ),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return CourseCard(
            curso: cursos[index],
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Curso curso;

  CourseCard({required this.curso});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(curso.nombreCurso),
            const SizedBox(height: 16),
            _buildInfoRow(
              leftText: curso.description,
              rightText: 'Instructor: ',
            ),
            const SizedBox(height: 16),
            _buildDivider(),
            const SizedBox(height: 16),
            _buildMeasurementRow('Detalles del curso', ''),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String leftText, required String rightText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.info,
                color: Colors.grey.withOpacity(0.5),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                leftText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Text(
            rightText,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 2,
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }

  Widget _buildMeasurementRow(String measurement, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            measurement,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
