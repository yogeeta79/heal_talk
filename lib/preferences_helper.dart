import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PreferencesHelper {
  Future<void> saveGoals(List<Map<String, dynamic>> goals) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String goalsString = jsonEncode(goals);
    await prefs.setString('goals', goalsString);
  }

  Future<List<Map<String, dynamic>>> loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? goalsString = prefs.getString('goals');
    if (goalsString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(goalsString));
    } else {
      return [
        {'title': 'Practice 5 min meditation', 'progress': 0.0},
        {'title': 'Write 3 positive affirmations', 'progress': 0.0},
        {'title': 'Reflect on your day', 'progress': 0.0},
      ];
    }
  }
}
