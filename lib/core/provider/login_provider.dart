import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  // String? authToken;
  int? userId;
  String? userName;
  String? userEmail;
  String? authToken;
  String? firstName;
  String? lastName;
  String? gender;
  String? profileId;
  int? age;
  void setToken(token, id, username, email, firstname, lastname, genderData,
      profileIdData, ageData) {
    userId = id;
    authToken = token;
    userName = username;
    userEmail = email;
    firstName = firstname;
    lastName = lastname;
    gender = genderData;
    profileId = profileIdData;
    age = ageData;
    print(
        " $authToken _ $userId _ $userName _ $userEmail _ $firstName _ $lastName _$genderData _$ageData _$profileId");
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
