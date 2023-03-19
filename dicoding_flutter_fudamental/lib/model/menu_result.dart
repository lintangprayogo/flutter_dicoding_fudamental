import 'package:dicoding_flutter_fudamental/model/menu_item.dart';

class MenuResult {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  const MenuResult({required this.foods, required this.drinks});

  factory MenuResult.fromJson(Map<String, dynamic> data) {
    List foods = data["foods"];
    List drinks = data["drinks"];

    return MenuResult(
        foods: foods.map((e) => MenuItem.fromJson(e)).toList(),
        drinks: drinks.map((e) => MenuItem.fromJson(e)).toList());
  }
}
