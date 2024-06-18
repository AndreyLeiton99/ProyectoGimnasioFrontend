import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mygym_app/models/course_response/course_response.dart';
import 'package:mygym_app/models/user_response/course_model.dart';
import 'package:mygym_app/providers/courses_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/getWeekday.dart';
import 'create_course_page.dart';
import 'edit_course_page.dart';

class ListViewCoursesCompletePage extends StatelessWidget {
  final List<CourseComplete> courses;

  const ListViewCoursesCompletePage({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final Weekday util = Weekday();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los Cursos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateCoursePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          final String day = util.getDayName(course.date.weekday);
          final String hour =
              DateFormat('h:mm a').format(course.date.toLocal());

          return CourseCompleteCard(course: course, day: day, hour: hour);
        },
      ),
    );
  }
}

class CourseCompleteCard extends StatelessWidget {
  final CourseComplete course;
  final String day;
  final String hour;

  const CourseCompleteCard({
    super.key,
    required this.course,
    required this.day,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CourseProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.nombreCurso,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Día: $day'),
                  const SizedBox(width: 100),
                  Text('Hora: $hour'),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                course.description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      courseProvider.deleteCourse(course.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Curso eliminado correctamente'),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCoursePage(course: course),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
