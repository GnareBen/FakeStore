import 'package:fake_store/data/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ProductRepositoryException implements Exception {
  final String message;
  ProductRepositoryException(this.message);
}

class ProductRepository {
  static Future<List<ProductModel>> getProducts() async {
    final client = http.Client();
    try {
      final http.Response response = await client.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode != 200) {
        throw ProductRepositoryException(
          'Failed to load products: Status Code ${response.statusCode}',
        );
      }

      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } on FormatException {
      throw ProductRepositoryException('Invalid data format');
    } on http.ClientException {
      throw ProductRepositoryException('Network error');
    } catch (e) {
      throw ProductRepositoryException('Unknown error: $e');
    }
  }
}
