import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopp/model/product.dart';

Future<List<ProductCategory>> fetchProductCategories() async {
  final response = await http.get(Uri.parse('https://mocki.io/v1/c23dd9e6-1426-4dd5-9e0e-e4ac789d1dcf'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => ProductCategory.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load product categories');
  }
}
