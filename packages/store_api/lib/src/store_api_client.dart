import 'dart:convert';
import 'package:http/http.dart' as http;

/// This class provides a Dart client for the Fake Store API.
class FakeStoreApiClient {
  final String _baseUrl = 'https://fakestoreapi.com';

  /// Returns a list of products from the Fake Store API.
  ///
  /// Throws an exception if the API call fails.
  Future<List<dynamic>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      final productJson = jsonDecode(response.body) as List;
      return productJson;
    } catch (_) {
      throw Exception('Failed to load products');
    }
  }
}
