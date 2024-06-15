import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/login_response.dart';

// TODO: Revisar en cada provider si se incluyen en en main.dart en MultiProvider
class AuthProvider extends ChangeNotifier {
  // URL base para las peticiones a la API
  final String baseURL = dotenv.env['BASE_URL']!;

  // JWT Token del usuario autenticado
  String? accessToken;

  // Guarda el usuario actual de la session
  Usuario? currentUser;

  // Método para iniciar sesión con las credenciales enviadas
  Future<VerifiedUser?> loginUser(String email, String password) async {
    // Construye la URL para la petición POST a la API de autenticación
    final url = Uri.parse('$baseURL/api/auth/local');

    // Crea el cuerpo de la petición con el email y contraseña
    // se usa "identifier" porque se puede loggear con username o email
    final body = {'identifier': email, 'password': password};

    // Realiza la petición POST para iniciar sesión
    final response = await http.post(url, body: body);

    // Verifica si la petición fue exitosa 
    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON en un mapa
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // Convierte la respuesta a un objeto VerifiedUser
      final userLoginResponse = VerifiedUser.fromJson(responseData);

      // Almacena el JWT token y el usuario actual
      accessToken = userLoginResponse.jwt;
      currentUser = userLoginResponse.user;

      // Notifica a los widgets "escuchando" cambios en el proveedor
      notifyListeners();

      // Devuelve el objeto VerifiedUser con la información de la sesión
      return userLoginResponse;
    } else {
      // TODO: Implementar manejo de errores para el inicio de sesión
      print('Error al iniciar sesión: ${response.statusCode}');
      return null;
    }
  }

  // Obtiene el rol de un usuario a partir del token JWT
  Future<String?> getRole(String jwtToken) async {
    // Construye la URL para la petición GET para obtener el rol
    final url = Uri.parse('$baseURL/api/users/me?populate=*');

    // Crea las cabeceras de la petición con el token JWT
    final headers = {'Authorization': 'Bearer $jwtToken'};

    // Realiza la petición GET para obtener el rol
    final response = await http.get(url, headers: headers);

    // Verifica si la petición fue exitosa 
    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON en un mapa
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // Extrae el objeto 'role' del JSON que forma el response del API
      final roleData = responseData['role'] as Map<String, dynamic>;

      print("ROL: ${roleData['name'] as String?}");

      // Extrae y retorna el nombre del rol del usuario
      return roleData['name'] as String?;
    } else {
      // si no hay un resultado de la peticion, devuelve null
      return null;
    }
  }

  // Cierra la sesión del usuario actual
  void logout() {
    print("Sesión cerrada, credenciales y token JWT reiniciados");
    // TODO: Implementar aqui que se elimine el Token guardado.
    accessToken = null;
    currentUser = null;
    notifyListeners();
  }
}

