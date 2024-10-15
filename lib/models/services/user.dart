import 'package:wildlife_api_connection/api_client.dart';
import 'package:wildlife_api_connection/models/user.dart';
import 'package:wildlife_api_connection/profile_api.dart';

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
      print("Get my profile failed: $e");
      throw ("Get my profile failed: $e");
    }
  }
}
