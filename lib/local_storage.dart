import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

class SharedPreferencesService {
  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  Future<void> saveUser(UserModel user) async {
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  /// Returns the saved User or null if none saved.
  UserModel? getUser() {
    final userString = prefs.getString('user');
    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> removeUser() async {
    await prefs.remove('user');
  }
}
