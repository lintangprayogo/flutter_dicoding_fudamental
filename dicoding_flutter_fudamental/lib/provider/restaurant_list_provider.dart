import 'package:dicoding_flutter_fudamental/data/api/api_service.dart';
import 'package:dicoding_flutter_fudamental/data/model/restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:flutter/widgets.dart';

class RestaurantListProvider extends ChangeNotifier {
  late String _message;
  late RestaurantResult _restaurantResult;
  late ResultState _state;
  final ApiService apiservice;

  RestaurantListProvider({required this.apiservice}) {
    restaurantList();
  }

  String get message => _message;
  RestaurantResult get restaurantResult => _restaurantResult;
  ResultState get state => _state;

  Future<dynamic> restaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiservice.getRestaurantList();
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
