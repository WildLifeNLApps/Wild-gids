import 'package:wildlife_api_connection/api_client.dart';
import 'package:wildlife_api_connection/auth_api.dart';

class AuthService {
  final _authApi = AuthApi(
    ApiClient("https://wildlifenl-uu-michi011.apps.cl01.cp.its.uu.nl/auth"),
  );

  Future<Map<String, dynamic>> authenticate(
    String email,
    String? displayNameApp,
    String? displayNameUser,
  ) async {
    try {
      final response = await _authApi.authenticate(
        displayNameApp ?? "",
        displayNameUser ?? "",
        email,
      );
      return Map<String, dynamic>.from(response);
    } catch (e) {
      print('Authentication failed: $e');
      throw Exception('Authentication failed: $e');
    }
  }

  Future<Map<String, dynamic>> authorize(
    String email,
    String code,
  ) async {
    try {
      final response = await _authApi.authorize(
        email,
        code,
      );
      return Map<String, dynamic>.from(response);
    } catch (e) {
      print('Authorize failed: $e');
      throw Exception('Authorize failed: $e');
    }
  }
}
