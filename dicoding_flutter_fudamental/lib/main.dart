import 'package:dicoding_flutter_fudamental/data/api/api_service.dart';
import 'package:dicoding_flutter_fudamental/data/db/database_helper.dart';
import 'package:dicoding_flutter_fudamental/data/preferences/preferences_helper.dart';
import 'package:dicoding_flutter_fudamental/page/home_page.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_detail.page.dart';
import 'package:dicoding_flutter_fudamental/page/restaurant_search_page.dart';
import 'package:dicoding_flutter_fudamental/provider/database_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/preferences_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_detail_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_list_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/restaurant_search_provider.dart';
import 'package:dicoding_flutter_fudamental/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantListProvider(apiservice: ApiService())),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(apiservice: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) {
            final provider = RestaurantDetailProvider(apiService: ApiService());
            final id = ModalRoute.of(context)?.settings.arguments as String;

            provider.getDetailRestaurant(id);

            return ChangeNotifierProvider(
              create: (context) => provider,
              child: RestaurantDetailPage(id: id),
            );
          },
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
        },
      ),
    );
  }
}
