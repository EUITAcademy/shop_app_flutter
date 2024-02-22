import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:shop_app_flutter/models/auth_data.dart';
import 'package:shop_app_flutter/models/shop_item.dart';
import 'package:shop_app_flutter/util/token_manager.dart';

abstract class ShopApi {
  // Local ip address(simulator doesn't understand localhost)
  static const String _baseUrl = 'http://182.178.11.10:8080';

  static Future<AuthData> login({
    required String email,
    required String password,
  }) async {
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    final Response response = await dio.post(
      '/login',
      data: jsonEncode({'email': email, 'password': password}),
    );
    // Note: here we do not have to jsonEncode(response.data),
    // because dio does it for us.
    return AuthData.fromJson(response.data);
  }

  static Future<AuthData> signup({
    required String email,
    required String password,
  }) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
      ),
    );
    final response = await dio.post(
      '/signup',
      data: jsonEncode({'email': email, 'password': password}),
    );
    return AuthData.fromJson(response.data);
  }

  static Future<List<ShopItem>> getProducts() async {
    final token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('token invalid');
    }
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    final response = await dio.get(
      '/products',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    final data = response.data['products'] as List<dynamic>;
    final items = List<ShopItem>.from(
      data.map(
        (model) => ShopItem.fromJson(model as Map<String, dynamic>),
      ),
    );

    return items;
  }

  static Future<String> order({required List<ShopItem> items}) async {
    final token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('token invalid');
    }
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    final response = await dio.post(
      '/order',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: jsonEncode({'order': items}),
    );
    final data = response.data as Map<String, dynamic>;
    final message = data['message'] as String;
    return message;
  }
}
