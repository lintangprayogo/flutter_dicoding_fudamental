import 'package:dicoding_flutter_fudamental/api/api_service.dart';
import 'package:dicoding_flutter_fudamental/model/detail_restaurant_result.dart';
import 'package:dicoding_flutter_fudamental/provider/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  late String _message;
  late DetailRestaurantResult _detailRestaurantResult;
  late ResultState _state;
  final ApiService apiService;

  String get message => _message;
  ResultState get state => _state;
  DetailRestaurantResult get detailRestaurantResult => _detailRestaurantResult;

  RestaurantDetailProvider({required this.apiService});

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _detailRestaurantResult = result;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString().replaceAll("Exception:", "");
    }
  }
}
