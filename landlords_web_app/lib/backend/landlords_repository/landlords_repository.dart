import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';

class LandlordsRepository {
  static const String _apiUrl = 'https://orca-app-nstmq.ondigitalocean.app/api';

  Future<List<Landlord>> fetchLandlords() async {
    try {
      final response = await http.get(Uri.parse('$_apiUrl/landlords'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Landlord.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<List<Landlord>> fetchLandlordById(Int id) async {
    try {
      final response = await http.get(Uri.parse('$_apiUrl/landlords/$id'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Landlord.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<void> createLandlord(
      String name, String email, String phoneNumber) async {
    final url = Uri.parse('$_apiUrl/landlords');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> updateLandlord(
      String name, String email, String phoneNumber, Int id) async {
    final url = Uri.parse('$_apiUrl/landlords/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> deleteLandlord(Int id) async {
    final url = Uri.parse('$_apiUrl/landlords/$id');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 204) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }
}
