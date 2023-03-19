import 'package:dicoding_flutter_fudamental/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/style/colors.dart';
import 'package:dicoding_flutter_fudamental/style/font.dart';
import 'package:dicoding_flutter_fudamental/widget/menu_list_tile.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = "/restaurantDetail";

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              flexibleSpace: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(restaurant.pictureId),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/btn_wishlist.png',
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ],
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
        ),
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
      itemCount: restaurant.menu.foods.length,
      itemBuilder: (context, index) {
        final food = restaurant.menu.foods[index];
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
      itemCount: restaurant.menu.drinks.length,
      itemBuilder: (context, index) {
        final drink = restaurant.menu.drinks[index];
        return MenuListTile(menu: drink.name);
      },
    ),
  );
}
