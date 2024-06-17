import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/user_response/user_model.dart';

import '../models/user_response/course_model.dart'; // Importa el modelo

class CourseProvider extends ChangeNotifier {
  // URL base para las peticiones a la API
  final String baseURL = dotenv.env['BASE_URL']!;

  // Lista para almacenar la respuesta de la carga de usuarios
  List<Course> courseResponseList = [];

  // Carga la lista de cursos del endpoint de Strapi
  Future<void> loadCourseResponseList() async {
    // Verifica si la lista se encuentra cargada para evitar peticiones innecesarias
    // TODO: Pensar si esta verificacion del inicio podria causar problemas de que no actualice la lista luego de agregar un nuevo User en ejecucion
    // !Lo de arriba se soluciona con un metodo para actualizar la lista, no va a interferir
    // if (courseResponseList.isEmpty) {
      // Construye la URL para la petición GET a la API
      final url = Uri.parse('$baseURL/api/cursos');

      try {
        // Realiza la petición GET a la API
        final resp = await http.get(url);

        // Verifica si la petición fue exitosa
        if (resp.statusCode == 200) {
          // Decodifica la respuesta JSON en una lista de objetos dinámicos
          print("Response cursos: ${resp.body}");
          final responseData = json.decode(resp.body) as List<dynamic>;

          // Convierte cada elemento de la lista dinámica a un objeto Course
          
          courseResponseList =
              responseData.map((userJson) => Course.fromJson(userJson)).toList();

          // Notifica a los widgets "escuchando" los cambios en la lista
          notifyListeners();
        } else {
          // Manejo de errores para peticiones fallidas
          print('Error cargando cursos: ${resp.statusCode}');
        }
      } catch (e) {
        // Manejo de errores para excepciones
        print('Error cargando cursos: $e');
      }
    // }
  }

  List<Course> getCourseList (){
    loadCourseResponseList();
    return courseResponseList;
  }
  // Busca un usuario por su ID en la lista cargada
  Course getCourseById(int id) {
    // Utiliza el método firstWhere para encontrar el primer usuario con el ID deseado
    return courseResponseList.firstWhere((course) => course.id == id);
  }
}
