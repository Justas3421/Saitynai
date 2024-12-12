import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:landlords_web_app/backend/flats_repository/flat.dart';

class FlatRepository {
  static const String _apiUrl = 'https://orca-app-nstmq.ondigitalocean.app/api';
  Future<List<Flat>> fetchFlats(
      {required int landlordId, required int buildingId}) async {
    try {
      final response = await http.get(Uri.parse(
          '$_apiUrl/landlords/$landlordId/buildings/$buildingId/flats'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Flat.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<List<Flat>> fetchFlatById(
      {required int landlordId,
      required int buildingId,
      required int flatId}) async {
    try {
      final response = await http.get(Uri.parse(
          '$_apiUrl/landlords/$landlordId/buildings/$buildingId/flats/$flatId'));

      if (response.statusCode == 200) {
        List<dynamic> landlordsJson = json.decode(response.body);
        return landlordsJson.map((json) => Flat.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load landlords: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Log the error for debugging purposes
      debugPrint('Error fetching landlords: $e');
      throw Exception('Failed to load landlords');
    }
  }

  Future<void> createFlat(Flat flat,
      {required int landlordId, required int buildingId}) async {
    final url =
        Uri.parse('$_apiUrl/landlords/$landlordId/buildings/$buildingId/flats');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "flatNumber": flat.flatNumber,
        "numBedrooms": flat.numBedrooms,
        "numBathrooms": flat.numBathrooms,
        "rent": flat.rent,
        "isOccupied": flat.isOccupied,
        "tenantName": flat.tenantName
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to create flat');
    }
  }

  Future<void> updateFlat(Flat flat,
      {required int landlordId,
      required int buildingId,
      required int flatId}) async {
    final url = Uri.parse(
        '$_apiUrl/landlords/$landlordId/buildings/$buildingId/flats/$flatId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "flatNumber": flat.flatNumber,
        "numBedrooms": flat.numBedrooms,
        "numBathrooms": flat.numBathrooms,
        "rent": flat.rent,
        "isOccupied": flat.isOccupied
      }),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }

  Future<void> deleteFlat(
      {required int landlordId,
      required int buildingId,
      required int flatId}) async {
    final url = Uri.parse(
        '$_apiUrl/landlords/$landlordId/buildings/$buildingId/flats/$flatId');
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
