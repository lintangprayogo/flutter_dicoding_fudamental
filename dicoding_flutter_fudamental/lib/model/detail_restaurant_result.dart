import 'package:dicoding_flutter_fudamental/model/restaurant.dart';

class DetailRestaurantResult {
  final bool error;
  final String message;
  final Restaurant restaurant;

  const DetailRestaurantResult(
      {required this.restaurant, required this.error, required this.message});

  factory DetailRestaurantResult.fromJson(Map<String, dynamic> data) {
    return DetailRestaurantResult(
        error: data["error"],
        message: data["message"],
        restaurant: Restaurant.fromJson(data["restaurant"]));
  }
}
