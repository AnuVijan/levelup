import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile.dart';

class ProfileService {

  Future<void> saveProfile(
    UserProfile profile,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'profile',
      jsonEncode(profile.toMap()),
    );
  }

  Future<UserProfile> loadProfile()
      async {

    final prefs =
        await SharedPreferences.getInstance();

    String? profileData =
        prefs.getString('profile');

    if (profileData == null) {
      return UserProfile(
        name: '',
        email: '',
        phone: '',
        imagePath: '',
      );
    }

    return UserProfile.fromMap(
      jsonDecode(profileData),
    );
  }
}