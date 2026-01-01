import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:omnicart/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  User? get user => _user;

  //register

  Future<void> register(String email, String password) async {
    _user = await _authService.register(email, password);
    notifyListeners();
  }

  //login
  Future<void> login(String email, String password) async {
    _user = await _authService.login(email, password);
    notifyListeners();
  }

  //logout

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
