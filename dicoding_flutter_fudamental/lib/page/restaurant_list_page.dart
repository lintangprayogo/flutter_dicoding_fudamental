import 'dart:convert';

import 'package:dicoding_flutter_fudamental/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/model/restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_detail.page.dart';
import 'package:dicoding_flutter_fudamental/widget/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = "/restaurantList";

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final TextEditingController _controller = TextEditingController();

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Restaurant"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: "Temukan",
                  hintText: "Temukan Restaurant",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/local_restaurant.json"),
              builder: (context, snapshot) {
                final listRestaurant = parseJson(snapshot.data)
                    .where((element) => element.name
                        .toUpperCase()
                        .contains(keyword.toUpperCase()))
                    .toList();
                if (listRestaurant.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: listRestaurant.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child:
                            RestaurantCard(restaurant: listRestaurant[index]),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RestaurantDetailPage.routeName,
                              arguments: listRestaurant[index]);
                        },
                      );
                    },
                  );
                } else {
                  return const Text("Tidak Ada Data");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Restaurant> parseJson(String? json) {
    if (json == null) {
      return [];
    }

    dynamic parsed = jsonDecode(json);

    RestaurantResult restaurantResult = RestaurantResult.fromJson(parsed);

    return restaurantResult.restaurants;
  }
}
