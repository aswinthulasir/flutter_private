import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase {
  static late SharedPreferences prefs;

  static Future<void> initialise() async {
    prefs = await SharedPreferences.getInstance();
  }

  void clearUserData() async {
    await prefs.remove("userid");
    await prefs.remove("email");
    await prefs.remove("name");
    await prefs.remove("phoneNumber");
    await prefs.remove("upiID");
  }

  void saveUserData({
    required String userId,
    required String email,
    required String name,
    required int phoneNumber,
    required String upiID,
  }) async {
    await prefs.setString("userid", userId);
    await prefs.setString("email", email);
    await prefs.setString("name", name);
    await prefs.setInt("phoneNumber", phoneNumber);
    await prefs.setString("upiID", upiID);
  }

  String? getUserId() {
    final userId = prefs.getString("userid");
    return userId;
  }

  String? getEmail() {
    final email = prefs.getString("email");
    return email!;
  }

  String? getName() {
    final name = prefs.getString("name");
    return name!;
  }

  int? getPhoneNumber() {
    final phoneNumber = prefs.getInt("phoneNumber");
    return phoneNumber!;
  }

  String? getUpiID() {
    final upiID = prefs.getString("upiID");
    return upiID!;
  }
}
