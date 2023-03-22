import 'package:dicoding_flutter_fudamental/api/api_service.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_detail.page.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_list_page.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_search_page.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService _apiService = ApiService();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => ChangeNotifierProvider(
            create: (context) =>
                RestaurantListProvider(apiservice: _apiService),
            child: const RestaurantListPage()),
        RestaurantDetailPage.routeName: (context) {
          final provider = RestaurantDetailProvider(apiService: _apiService);
          final id = ModalRoute.of(context)?.settings.arguments as String;

          provider.getDetailRestaurant(id);

          return ChangeNotifierProvider(
            create: (context) => provider,
            child: RestaurantDetailPage(id: id),
          );
        },
        RestaurantSearchPage.routeName: (context) => ChangeNotifierProvider(
            create: (context) =>
                RestaurantSearchProvider(apiservice: _apiService),
            child: const RestaurantSearchPage())
      },
    );
  }
}
