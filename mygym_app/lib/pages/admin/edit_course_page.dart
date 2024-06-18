import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mygym_app/models/course_response/course_response.dart';

class EditCoursePage extends StatefulWidget {
  final CourseComplete course;

  const EditCoursePage({Key? key, required this.course}) : super(key: key);

  @override
  _EditCoursePageState createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.course.nombreCurso);
    _descriptionController =
        TextEditingController(text: widget.course.description);
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.course.date));
    _timeController = TextEditingController(
        text: DateFormat('h:mm a').format(widget.course.date));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Curso',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la descripción del curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Fecha (yyyy-mm-dd)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha del curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Hora (h:mm a)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la hora del curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  /*if (_formKey.currentState!.validate()) {
                    final updatedCourse = CourseComplete(
                      id: widget.course.id,
                      nombreCurso: _nameController.text,
                      description: _descriptionController.text,
                      date: DateTime.parse(_dateController.text),
                    );

                    context.read<CourseProvider>().updateCourse(updatedCourse);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Curso actualizado correctamente')),
                    );

                    Navigator.pop(context);
                  } */
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
