import 'package:flutter/material.dart';
import 'package:mygym_app/models/course_response/course_response.dart';
import 'package:mygym_app/providers/courses_provider.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Curso'),
      ),
      body: Stack(
        children: <Widget>[
          const CourseHeaderImage(),
          CourseForm(
              infoHeight: 364.0,
              tempHeight: MediaQuery.of(context).size.height),
        ],
      ),
    );
  }
}

class CourseHeaderImage extends StatelessWidget {
  const CourseHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.asset(
            'assets/gym.jpeg',
            color: const Color.fromARGB(70, 106, 115, 116),
            colorBlendMode: BlendMode.modulate,
          ),
        ),
      ],
    );
  }
}

class CourseForm extends StatefulWidget {
  const CourseForm(
      {super.key, required this.infoHeight, required this.tempHeight});

  final double infoHeight;
  final double tempHeight;

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final coursesProvider = context.watch<CourseProvider>();

    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: GymAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: GymAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: widget.infoHeight,
                maxHeight: widget.tempHeight > widget.infoHeight
                    ? widget.tempHeight
                    : widget.infoHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0, left: 18, right: 16),
                    child: Text(
                      'Crear Nuevo Curso',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        letterSpacing: 0.27,
                        color: GymAppTheme.darkerText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 8, top: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del Curso',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el nombre del curso';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Descripción',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese una descripción';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Fecha',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese la fecha';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _timeController,
                            decoration: const InputDecoration(
                              labelText: 'Hora',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese la hora';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 75),
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      // Simular la creación del curso
                                      /* Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          _isLoading = false;
                                          final newCourse = CourseComplete(
                                            id: DateTime.now()
                                                .millisecondsSinceEpoch, // Generar ID temporal
                                            nombreCurso: _nameController.text,
                                            description:
                                                _descriptionController.text,
                                            date: DateTime.parse(
                                                _dateController.text),
                                            time: _timeController.text,
                                          );

                                          coursesProvider.addCourse(newCourse);
                                          Navigator.pop(context);
                                        });
                                      });*/
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 26, 28, 28),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 45),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Crear Curso',
                                    style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
