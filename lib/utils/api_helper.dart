import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<List<T>> getData<T>(
      Uri uri,
      T Function(Map<String, dynamic>) fromJson,
      http.Client client,
      ) async {
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('Not found: ${uri.toString()}');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error: ${uri.toString()}');
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Could not fetch data: $e');
    }
  }
}

