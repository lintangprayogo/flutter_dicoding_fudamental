import 'dart:ffi';

import 'package:dicoding_flutter_fudamental/model/menu_result.dart';

class Restaurant {
  final String id;
  final String name;
  final String pictureId;
  final String city;
  final double rating;
  final String description;
  final MenuResult menu;

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
      menu: MenuResult.fromJson(data["menus"]));
}
