class BuildingRepository {
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
}
