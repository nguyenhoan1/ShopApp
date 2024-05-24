// lib/shared_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  String get lastVisitedPage => _preferences.getString('last_visited_page') ?? 'None';

  Future<void> setLastVisitedPage(String page) {
    return _preferences.setString('last_visited_page', page);
  }
}
