import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/course_response/course_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mygym_app/models/user_response/course_model.dart';

class CourseProvider extends ChangeNotifier {
  List<CourseComplete> _courses = [];

  List<CourseComplete> get courses => _courses;

  Future<void> fetchCourses() async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final response = await http.get(Uri.parse('$baseUrl/api/cursos?populate=*'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data'] as List;

      _courses = data.map((courseJson) => CourseComplete.fromJson(courseJson)).toList();
      print('Cantidad de cursos: ${_courses.length}');
      notifyListeners();
    } else {
      print('Error al cargar los cursos desde provider');
    }
  }

  Future<void> createCourse(Course course) async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/cursos');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful creation here
      print('Curso creado exitosamente!');
    } else {
      throw Exception('Fallo en el proceso. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateCourse(Course course) async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/cursos/${course.id}');

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle successful update here
      print('Curso actualizado exitosamente!');
    } else {
      throw Exception('Fallo en la actualización. Status code: ${response.statusCode}');
    }
  }


  Future<bool> deleteCourse(int id) async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    final url = Uri.parse('$baseUrl/api/cursos/$id');

    final response = await http.delete(
      url
    );

    if (response.statusCode == 200) {
      // Handle successful creation here
      print('Curso eliminado exitosamente!');
      return true;
    } else {
      print('Fallo en el proceso. Status code: ${response.statusCode}');
      return false;
    }
  }

}
