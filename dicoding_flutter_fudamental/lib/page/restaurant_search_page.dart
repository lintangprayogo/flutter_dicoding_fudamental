import 'dart:convert';

import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/data/model/restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_search_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:dicoding_flutter_fudamental/widget/error_widget.dart';
import 'package:dicoding_flutter_fudamental/widget/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = "/searchRestaurant";

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController _controller = TextEditingController();

  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cari Restaurant"),
      ),
      body: _buildList(),
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

  Widget _buildList() {
    return Consumer<RestaurantSearchProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                  provider.searchRestaurant(keyword);
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
              child: provider.state == ResultState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.state == ResultState.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              provider.restaurantResult.restaurants.length,
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                                restaurant: provider
                                    .restaurantResult.restaurants[index]);
                          },
                        )
                      : provider.state == ResultState.error
                          ? ErrorMessage(
                              message: provider.message,
                              tryAgain: () {
                                provider.searchRestaurant(keyword);
                              })
                          : provider.state == ResultState.noData
                              ? const Center(child: Text("Tidak Temukan"))
                              : const SizedBox())
        ],
      );
    });
  }
}
