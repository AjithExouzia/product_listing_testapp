import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  /// Fetch all products from the Fake Store API
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Fetch products by category
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/category/$category'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  /// Fetch a single product by ID
  Future<Product> fetchProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Product.fromJson(json);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  /// Get all available categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/categories'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.cast<String>();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
