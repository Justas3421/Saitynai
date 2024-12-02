import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:landlords_web_app/backend/auth_repository/models/user.dart';

class AuthRepository {
  static const String _apiUrl = 'https://orca-app-nstmq.ondigitalocean.app/api';

  Future<User> login(String username, String password) async {
    final url = Uri.parse('$_apiUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String accessToken = data['accessToken'];
      final String refreshToken = data['refreshToken'];
      // Store tokens or handle them as needed
      return User(
          username: username,
          password: password,
          accessToken: accessToken,
          refreshToken: refreshToken);
    } else {
      // Handle error
      throw Exception('Failed to login');
    }
  }

  Future<void> register(String email, String password, String username) async {
    // Register logic
  }

  Future<void> logout() async {
    // Logout logic
  }
}
