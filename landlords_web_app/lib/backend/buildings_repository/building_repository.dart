import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:landlords_web_app/backend/buildings_repository/building.dart';
import 'package:http/http.dart' as http;

class BuildingRepository {
  static const String _apiUrl = 'https://orca-app-nstmq.ondigitalocean.app/api';
  Future<List<Building>> fetchBuildings(int landlordId) async {
    try {
      final response =
          await http.get(Uri.parse('$_apiUrl/landlords/$landlordId/buildings'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Building.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<List<Building>> fetchBuidlingById(
      int landlordId, int buildingId) async {
    try {
      final response = await http.get(
          Uri.parse('$_apiUrl/landlords/$landlordId/buildings/$buildingId'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Building.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<void> createBuilding(String name, String address, String city,
      String state, String zipCode, String numFloors,
      {required int landlordId}) async {
    final url = Uri.parse('$_apiUrl/landlords/$landlordId/buildings');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "numFloors": numFloors
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> updateBuilding(String name, String address, String city,
      String state, String zipCode, String numFloors,
      {required int landlordId, required int buildingId}) async {
    final url =
        Uri.parse('$_apiUrl/landlords/$landlordId/buildings/$buildingId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "numFloors": numFloors
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> deleteBuilding(
      {required int landlordId, required int buildingId}) async {
    final url =
        Uri.parse('$_apiUrl/landlords/$landlordId/buildings/$buildingId');
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
