import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';

class SearchRestaurantResult {
  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  const SearchRestaurantResult({
    required this.restaurants,
    required this.founded,
    required this.error,
  });

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> data) {
    List? parsedRestaurant = data["restaurants"];
    return SearchRestaurantResult(
        error: data["error"],
        founded: data['founded'] == null ? 0 : data['founded'].toInt(),
        restaurants: parsedRestaurant == null
            ? []
            : parsedRestaurant
                .map((data) => Restaurant.fromJson(data))
                .toList());
  }
}
