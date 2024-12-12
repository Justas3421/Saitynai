import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
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
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      print(decodedToken);
      // Store tokens or handle them as needed
      return User(
          username: username,
          password: password,
          accessToken: accessToken,
          refreshToken: refreshToken,
          role: UserRoleExtension.fromString(decodedToken[
              "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"]),
          userId: decodedToken["sub"]);
    } else {
      // Handle error
      throw Exception('Failed to login');
    }
  }

  Future<User> register(
      String email, String password, String username, UserRole role) async {
    final url = Uri.parse('$_apiUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userName": username,
        "email": email,
        "password": password,
        "role": role.stringValue
      }),
    );
    if (response.statusCode == 201) {
      User user = await login(username, password);
      return user;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> logout() async {
    // Logout logic
  }
}
