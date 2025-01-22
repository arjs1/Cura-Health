import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // String? authToken;
  int? userId;
  String? userName;
  String? userEmail;
  String? authToken;
  String? firstName;
  String? lastName;
  void setToken(token, id, username, email, firstname, lastname) {
    userId = id;
    authToken = token;
    userName = username;
    userEmail = email;
    firstName = firstname;
    lastName = lastname;
    print(
        " $authToken _ $userId _ $userName _ $userEmail _ $firstName _ $lastName");
    notifyListeners();
  }
}
