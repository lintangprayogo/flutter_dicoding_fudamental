import 'package:dicoding_flutter_fudamental/model/restaurant.dart';

class RestaurantResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  const RestaurantResult(
      {required this.restaurants,
      required this.count,
      required this.error,
      required this.message});

  factory RestaurantResult.fromJson(Map<String, dynamic> data) {
    List? parsedRestaurant = data["restaurants"];
    return RestaurantResult(
        error: data["error"],
        message: data["message"],
        count: data['count'] == null ? 0 : data['count'].toInt(),
        restaurants: parsedRestaurant == null
            ? []
            : parsedRestaurant
                .map((data) => Restaurant.fromJson(data))
                .toList());
  }
}
