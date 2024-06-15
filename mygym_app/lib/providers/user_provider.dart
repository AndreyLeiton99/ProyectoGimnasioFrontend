import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/user_response.dart';

// TODO: Revisar en cada provider si se incluyen en en main.dart en MultiProvider
class UserProvider extends ChangeNotifier {
  // URL base para las peticiones a la API
  final String baseURL = dotenv.env['BASE_URL']!;

  // Lista para almacenar la respuesta de la carga de usuarios
  List<User> userResponseList = [];

  // Carga la lista de usuarios del endpoint de Strapi
  Future<void> loadPublicUserResponseList() async {
    // Verifica si la lista se encuentra cargada para evitar peticiones innecesarias
    if (userResponseList.isEmpty) {
      // Construye la URL para la petición GET a la API
      // el '?populate=*' permite obtener una respuesta con las relaciones incluidas
      final url = Uri.parse('$baseURL/api/users?populate=*');

      // Realiza la petición GET a la API
      final resp = await http.get(url);

      // Verifica si la petición fue exitosa
      if (resp.statusCode == 200) {
        // Decodifica la respuesta JSON en una lista de objetos dinámicos
        final responseData = json.decode(resp.body) as List<dynamic>;

        // Convierte cada elemento de la lista dinámica a un objeto User
        userResponseList = responseData.map((userJson) => User.fromJson(userJson)).toList();

        // Notifica a los widgets "escuchando" los cambios en la lista
        notifyListeners();

        // si el estado del request es incorrecta, informe el codigo de error
      } else {
        // TODO: Implementar manejo de errores para peticiones fallidas
        print('Error cargando usuarios: ${resp.statusCode}');
      }
    }
  }

  // Obtiene los cursos de un usuario por su ID
  Future<List<Curso>> getCoursesForUser(int userId) async {
    // Construye la URL de la API para recuperar los cursos del usuario especificado.
    final url = Uri.parse('$baseURL/api/users/$userId?populate=*');
    // Envia una solicitud GET a la URL de la API construida.
    final response = await http.get(url);

    // Procesa la respuesta de la API
    if (response.statusCode == 200) {
      // Decodifica el cuerpo de la respuesta JSON
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      // Extrae la lista de cursos de los datos de esa respuesta.
      final coursesList = responseData['cursos'] as List<dynamic>;
      // Convierte cada objeto JSON de curso en un objeto Curso.
      final convertedCourses = coursesList.map((courseJson) => Curso.fromJson(courseJson)).toList();

      // Devuelve la lista de Cursos asociados al User.
      return convertedCourses;
    } else {
      // Maneja el error de la solicitud de la API.
      print('Error cargando cursos para el usuario $userId: ${response.statusCode}');

      // Devuelve una lista vacia en caso de error.
      return [];
    }
  }



  // Busca un usuario por su ID en la lista cargada
  User getUserById(int id) {
    // Utiliza el método firstWhere para encontrar el primer usuario con el ID deseado
    return userResponseList.firstWhere((user) => user.id == id);
  }
}
