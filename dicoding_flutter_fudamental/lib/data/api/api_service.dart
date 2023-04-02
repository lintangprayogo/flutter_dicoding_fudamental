import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dicoding_flutter_fudamental/data/model/detail_restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/data/model/restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/data/model/search_restaurant_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantResult> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}list"));
      if (response.statusCode == 200) {
        final result = RestaurantResult.fromJson(jsonDecode(response.body));
        return result;
      } else {
        throw Exception('Failed Load List Restaurant');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('There Is No Internet');
      } else if (e is TimeoutException) {
        throw Exception('To Long Wait For Response');
      } else {
        throw ("Unhandled exception: ${e.toString()}");
      }
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
      if (response.statusCode == 200) {
        return DetailRestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed Load Restaurant');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('There Is No Internet');
      } else if (e is TimeoutException) {
        throw Exception('To Long Wait For Response');
      } else {
        throw ("Unhandled exception: ${e.toString()}");
      }
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
      if (response.statusCode == 200) {
        return SearchRestaurantResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed Load Restaurant');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('There Is No Internet');
      } else if (e is TimeoutException) {
        throw Exception('To Long Wait For Response');
      } else {
        throw ("Unhandled exception: ${e.toString()}");
      }
    }
  }
}
