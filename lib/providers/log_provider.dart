import 'package:flutter/material.dart';

class LogProvider extends ChangeNotifier {
  int _userId = 1;
  String _username = "User 1";

  int get userId => _userId;
  String get username => _username;

  void login(String username, String password) {
    _userId = 1;
    _username = "User 1";
    notifyListeners();
  }
}