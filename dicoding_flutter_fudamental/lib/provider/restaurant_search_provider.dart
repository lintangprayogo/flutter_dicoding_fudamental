import 'package:dicoding_flutter_fudamental/api/api_service.dart';
import 'package:dicoding_flutter_fudamental/model/detail_restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/model/search_restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:flutter/widgets.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  late String _message;
  late SearchRestaurantResult _restaurantResult;
  ResultState _state = ResultState.idle;
  final ApiService apiservice;

  RestaurantSearchProvider({required this.apiservice});

  String get message => _message;
  SearchRestaurantResult get restaurantResult => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String search) async {
    try {
      if (search.isEmpty) {
        _state = ResultState.idle;
        notifyListeners();
        return _restaurantResult = const SearchRestaurantResult(
            restaurants: [], founded: 0, error: false);
      }
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiservice.searchRestaurant(search);
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Tidak Ada Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString().replaceAll("Exception:", "");
    }
  }
}
