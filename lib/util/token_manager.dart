import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_flutter/models/auth_data.dart';

abstract class TokenManager {
  static Future<void> setToken(AuthData authData) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedMap = jsonEncode({
      'token': authData.token,
      'exp': authData.exp,
    });
    prefs.setString('tokenMap', encodedMap);
  }

  static bool _isTokenExpired(String exp) {
    final DateTime expDate = DateTime.parse(exp);
    final now = DateTime.now();
    final isExpired = expDate.isBefore(now);
    return isExpired;
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonTokenMap = prefs.getString('tokenMap');
    if (jsonTokenMap != null) {
      final tokenMap = jsonDecode(jsonTokenMap) as Map<String, dynamic>;
      final token = tokenMap['token'] as String;
      final exp = tokenMap['exp'] as String;

      final isExpired = _isTokenExpired(exp);

      if (!isExpired) {
        return token;
      }
    }
    return null;
  }
}
