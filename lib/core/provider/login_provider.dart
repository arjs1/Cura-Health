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

  void updateFirstName(String newFirstName) {
    firstName = newFirstName;
    notifyListeners();
  }

  void updateLastName(String newLastName) {
    lastName = newLastName;
    notifyListeners();
  }

  void updateFields(String newFirstName, String newLastName, String newUserName,
      String newEmail) {
    print(firstName);
    print(lastName);
    // firstName = newFirstName;
    // lastName = newLastName;
    if (newFirstName != "") {
      firstName = newFirstName;
    } else {
      firstName = firstName;
    }
    if (newLastName != "") {
      lastName = newLastName;
    } else {
      lastName = lastName;
    }
    if (newUserName != "") {
      userName = newUserName;
    } else {
      userName = userName;
    }
    if (newEmail != "") {
      userEmail = newEmail;
    } else {
      userEmail = userEmail;
    }
    print("-" + newFirstName);
    print("-" + newLastName);
    notifyListeners();
  }
}
