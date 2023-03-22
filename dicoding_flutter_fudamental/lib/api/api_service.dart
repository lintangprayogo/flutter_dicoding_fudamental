import 'dart:convert';

import 'package:dicoding_flutter_fudamental/model/detail_restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/model/restaurant_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantResult> getRestaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      final result = RestaurantResult.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception('Failed Load List Restaurant');
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Restaurant');
    }
  }
}
