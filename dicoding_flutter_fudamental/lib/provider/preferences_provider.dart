import 'package:dicoding_flutter_fudamental/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRemainderPreferences();
  }

  bool _isDailyRemainderActive = false;
  bool get isDailyRemainderActive => _isDailyRemainderActive;

  void _getDailyRemainderPreferences() async {
    _isDailyRemainderActive = await preferencesHelper.isDailyRemainderActive;
    notifyListeners();
  }

  void enableDailyRemainder(bool value) {
    preferencesHelper.setDailyRemainder(value);
    _getDailyRemainderPreferences();
  }
}
