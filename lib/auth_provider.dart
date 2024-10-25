import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // This method could interact with Firebase Auth or other services to log in the user
  void login() {
    _isLoggedIn = true;
    notifyListeners(); // Notifies listeners that the login state has changed
  }

  // This method could interact with Firebase Auth or other services to log out the user
  void logout() {
    _isLoggedIn = false;
    notifyListeners(); // Notifies listeners that the logout state has changed
  }
}
