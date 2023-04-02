import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:dicoding_flutter_fudamental/common/colors.dart';
import 'package:dicoding_flutter_fudamental/common/font.dart';
import 'package:dicoding_flutter_fudamental/util/util.dart';
import 'package:dicoding_flutter_fudamental/widget/error_widget.dart';
import 'package:dicoding_flutter_fudamental/widget/menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = "/restaurantDetail";
  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: _buildResult(id),
      ),
    );
  }
}

Widget _buildFoodList(Restaurant restaurant) {
  return Container(
    margin: const EdgeInsets.only(left: 28, top: 10),
    height: 50,
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: restaurant.menu!.foods.length,
      itemBuilder: (context, index) {
        final food = restaurant.menu!.foods[index];
        return MenuListTile(menu: food.name);
      },
    ),
  );
}

Widget _buildDrinksList(Restaurant restaurant) {
  return Container(
    margin: const EdgeInsets.only(left: 28, top: 10),
    height: 50,
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: restaurant.menu!.drinks.length,
      itemBuilder: (context, index) {
        final drink = restaurant.menu!.drinks[index];
        return MenuListTile(menu: drink.name);
      },
    ),
  );
}

Widget _buildContent(Restaurant restaurant, BuildContext context) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("$baseImagePath${restaurant.pictureId}"),
                  fit: BoxFit.fill)),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 24),
                    child: Text(
                      restaurant.name,
                      style: text27BlackSemiBold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          size: 20,
                          color: greyColor,
                        ),
                        Text(
                          restaurant.city,
                          style: text20GreySemiBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(right: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rate,
                      size: 16,
                      color: orangeColor,
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: text16BlackSemiBold,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 28, top: 10),
          child: Text(
            "Deskripsi",
            style: text16BlackSemiBold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 28, top: 5, right: 28),
          child: Text(
            restaurant.description,
            style: text14GreySemiBold,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 28, top: 10),
          child: Text(
            "Makanan",
            style: text16BlackSemiBold,
          ),
        ),
        _buildFoodList(restaurant),
        Container(
          margin: const EdgeInsets.only(left: 28, top: 10),
          child: Text(
            "Minuman",
            style: text16BlackSemiBold,
          ),
        ),
        _buildDrinksList(restaurant)
      ]))
    ],
  );
}

Widget _buildResult(String id) {
  return Consumer<RestaurantDetailProvider>(builder: (context, value, child) {
    if (value.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (value.state == ResultState.hasData) {
      return _buildContent(value.detailRestaurantResult.restaurant, context);
    } else if (value.state == ResultState.error) {
      return ErrorMessage(
          message: value.message,
          tryAgain: () {
            value.getDetailRestaurant(id);
          });
    } else {
      return const Center(child: Text("Tidak Ada Data"));
    }
  });
}
