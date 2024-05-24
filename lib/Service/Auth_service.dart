import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final SharedPreferences _preferences = GetIt.instance<SharedPreferences>();

  Future<void> saveUserCredentials(String email, String password) async {
    await _preferences.setString('email', email);
    await _preferences.setString('password', password);
  }

  String? getUserEmail(){
    return _preferences.getString('email');
  }
  String? getUserPassword(){
    return _preferences.getString('password');
  }
  Future<void> updateUserEmail(String email) async {
    await _preferences.setString('email', email);
  }

  Future<void> updateUserPassword(String password) async {
    await _preferences.setString('password', password);
  }

  bool isLoggedIn() {
    return _preferences.containsKey('email')!= null && 
    _preferences.containsKey('password') != null;
  }
}