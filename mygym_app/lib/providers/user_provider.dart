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

  // Busca un usuario por su ID en la lista cargada
  User getUserById(int id) {
    // Utiliza el método firstWhere para encontrar el primer usuario con el ID deseado
    return userResponseList.firstWhere((user) => user.id == id);
  }
}
