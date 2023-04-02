import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRemainder = 'DAILY_REMAINDER';

  Future<bool> get isDailyRemainderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRemainder) ?? false;
  }

  void setDailyRemainder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRemainder, value);
  }
}
