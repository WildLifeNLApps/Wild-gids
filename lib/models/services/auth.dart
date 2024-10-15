import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wildlife_api_connection/api_client.dart';
import 'package:wildlife_api_connection/auth_api.dart';
import 'package:wildlife_api_connection/models/user.dart';

class AuthService {
  final _authApi = AuthApi(
    ApiClient("https://wildlifenl-uu-michi011.apps.cl01.cp.its.uu.nl/auth"),
  );
  final _storage = new FlutterSecureStorage();

  Future<Map<String, dynamic>> authenticate(
    String email,
    String? displayNameApp,
  ) async {
    try {
      final response = await _authApi.authenticate(
        displayNameApp ?? "",
        email,
      );

      return Map<String, dynamic>.from(response);
    } catch (e) {
      print('Authentication failed: $e');
      throw Exception('Authentication failed: $e');
    }
  }

  Future<User> authorize(
    String email,
    String code,
  ) async {
    try {
      final response = await _authApi.authorize(
        email,
        code,
      );

      await _storage.write(key: "bearerToken", value: response.id);
      return response;
    } catch (e) {
      print('Authorize failed: $e');
      throw Exception('Authorize failed: $e');
    }
  }

  Future<String?> getBearerToken() async {
    try {
      return await _storage.read(key: "bearerToken");
    } catch (e) {
      print('Failed to get bearer token: $e');
      throw Exception('Failed to get bearer token: $e');
    }
  }
}
