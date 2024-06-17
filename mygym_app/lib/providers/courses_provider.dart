import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/course_response/course_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      throw Exception('Failed to load courses');
    }
  }
}
