import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/login_response.dart';

// TODO: Revisar en cada provider si se incluyen en en main.dart en MultiProvider
class AuthProvider extends ChangeNotifier {
  final String baseURL = dotenv.env['BASE_URL']!;
  String? accessToken;
  Usuario? currentUser;

  Future<VerifiedUser?> loginUser(String email, String password) async {
    final url = Uri.parse('$baseURL/api/auth/local');
    final body = {'identifier': email, 'password': password};
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      final userLoginResponse = VerifiedUser.fromJson(responseData);
      accessToken = userLoginResponse.jwt;
      currentUser = userLoginResponse.user;
      notifyListeners();
      return userLoginResponse;
    } else {
      // TODO: Manejar el error apropiadamente
      print('Login error: ${response.statusCode}');
      return null;
    }
  }

  Future<String?> getRole(String jwtToken) async {
  final url = Uri.parse('$baseURL/api/users/me?populate=*');
  final headers = {'Authorization': 'Bearer $jwtToken'};
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    final roleData = responseData['role'] as Map<String, dynamic>; // Assuming 'role' exists
    print("ROLE: ${roleData['name'] as String?}");
    return roleData['name'] as String?; // Extract and return role name
  } else {
    // Handle error fetching role
    return null;
  }
}

  void logout() {
    print("Logout done, credentials and JWT Token now reset");
    accessToken = null;
    currentUser = null;
    notifyListeners();
  }
}
