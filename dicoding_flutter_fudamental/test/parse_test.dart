import 'package:dicoding_flutter_fudamental/data/model/menu_result.dart';
import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

var mockRestaurant = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Lintang",
  "description": "desc",
  "pictureId": "26",
  "city": "Jakarta",
  "rating": 4.5
};
void main() {
  test("Test Parsing Data", () async {
    var expexcted = const Restaurant(
        id: "s1knt6za9kkfw1e867",
        name: "Kafe Lintang",
        city: "Jakarta",
        rating: 4.5,
        pictureId: "26",
        description: "desc",
        menu: MenuResult(foods: [], drinks: []));
    var result = Restaurant.fromJson(mockRestaurant);

    expect(
        result.id == expexcted.id &&
            result.name == expexcted.name &&
            result.city == expexcted.city &&
            result.description == expexcted.description &&
            result.pictureId == expexcted.pictureId &&
            result.rating == expexcted.rating,
        true);
  });
}
