import 'dart:convert';

import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/data/model/restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_search_page.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:dicoding_flutter_fudamental/widget/error_widget.dart';
import 'package:dicoding_flutter_fudamental/widget/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = "/restaurantList";

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Restaurant"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              },
              child: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: _buildList());
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
    return Consumer<RestaurantListProvider>(builder: (context, value, child) {
      if (value.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (value.state == ResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.restaurantResult.restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantCard(
                restaurant: value.restaurantResult.restaurants[index]);
          },
        );
      } else if (value.state == ResultState.error) {
        return ErrorMessage(
            message: value.message,
            tryAgain: () {
              value.restaurantList();
            });
      } else {
        return const Center(child: Text("Tidak Ada Data"));
      }
    });
  }
}
