import 'package:dicoding_flutter_fudamental/model/restaurant.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_detail.page.dart';
import 'package:dicoding_flutter_fudamental/style/colors.dart';
import 'package:dicoding_flutter_fudamental/style/font.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(restaurant.pictureId)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
