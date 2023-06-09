import 'package:dicoding_flutter_fudamental/data/model/menu_result.dart';

class Restaurant {
  final String id;
  final String name;
  final String pictureId;
  final String city;
  final double rating;
  final String description;
  final MenuResult? menu;

  const Restaurant(
      {required this.id,
      required this.name,
      required this.city,
      required this.rating,
      required this.pictureId,
      required this.description,
      required this.menu});

  factory Restaurant.fromJson(Map<String, dynamic> data) => Restaurant(
      id: data['id'],
      name: data['name'],
      city: data['city'],
      rating: data['rating'].toDouble(),
      pictureId: data['pictureId'],
      description: data['description'],
      menu: data['menus'] == null
          ? const MenuResult(foods: [], drinks: [])
          : MenuResult.fromJson(data['menus']));

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'description': description
    };
  }
}
