import 'package:flutter/foundation.dart';
import 'package:wildgids/models/services/auth.dart';
import 'package:wildlife_api_connection/api_client.dart';
import 'package:wildlife_api_connection/models/user.dart';
import 'package:wildlife_api_connection/profile_api.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final _profileApi = ProfileApi(
    ApiClient(
        "https://wildlifenl-uu-michi011.apps.cl01.cp.its.uu.nl/profile/me"),
  );

  Future<User> getMyProfile() async {
    try {
      final response = await _profileApi.getMyProfile();
      return response;
    } catch (e) {
      debugPrint("Get my profile failed: $e");
      throw ("Get my profile failed: $e");
    }
  }

  Future<User> updateMyProfile(String name) async {
    try {
      final token = await AuthService().getBearerToken();
      var url = Uri.parse(
          "https://wildlifenl-uu-michi011.apps.cl01.cp.its.uu.nl/profile/me/");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "name": name,
        }),
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to update profile: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Update my profile failed: $e");
      throw Exception("Update my profile failed: $e");
    }
  }
}
