import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mygym_app/models/user_response.dart';

// TODO: Revisar en cada provider si se incluyen en en main.dart en MultiProvider
class UserProvider extends ChangeNotifier {
  final String baseURL = dotenv.env['BASE_URL']!;
  List<User> userResponseList = [];

  Future<void> loadPublicUserResponseList() async {
    if (userResponseList.isEmpty) {
      final url = Uri.parse('$baseURL/api/users?populate=*');
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final responseData = json.decode(resp.body) as List<dynamic>;
        userResponseList = responseData.map((userJson) => User.fromJson(userJson)).toList();
        notifyListeners();
      } else {
        // todo: manejar el error
        print('Error loading users: ${resp.statusCode}');
      }
    }
  }

  User getUserById(int id) {
    return userResponseList.firstWhere((user) => user.id == id);
  }
}
