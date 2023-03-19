import 'package:dicoding_flutter_fudamental/model/restaurant.dart';

class RestaurantResult {
  final List<Restaurant> restaurants;

  const RestaurantResult({required this.restaurants});

  factory RestaurantResult.fromJson(Map<String, dynamic> data) {
    List parsedRestaurant = data["restaurants"];
    return RestaurantResult(
        restaurants:
            parsedRestaurant.map((data) => Restaurant.fromJson(data)).toList());
  }
}
