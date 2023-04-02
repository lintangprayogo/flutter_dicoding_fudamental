import 'package:dicoding_flutter_fudamental/data/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_detail.page.dart';
import 'package:dicoding_flutter_fudamental/common/colors.dart';
import 'package:dicoding_flutter_fudamental/common/font.dart';
import 'package:dicoding_flutter_fudamental/provider/database_provider.dart';
import 'package:dicoding_flutter_fudamental/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: restaurant.id);
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: double.infinity,
                            height: 200.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "$baseImagePath${restaurant.pictureId}")),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: isFavorite
                                  ? IconButton(
                                      icon: const Icon(Icons.thumb_up),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onPressed: () => provider
                                          .removeFavorite(restaurant.id),
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.thumb_up_outlined),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onPressed: () => provider.addFavorite(
                                        restaurant,
                                      ),
                                    )),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 10, right: 24, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style: text16BlackSemiBold,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        size: 20,
                                        color: greyColor,
                                      ),
                                      Text(
                                        restaurant.city,
                                        style: text14GreySemiBold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate,
                                    size: 14,
                                    color: orangeColor,
                                  ),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: text16BlackSemiBold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            );
          });
    });
  }
}
