import 'dart:convert';

import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:cure_health_app/features/loginpage/widgets/text_widget_field.dart';

import 'package:cure_health_app/features/profilePage/profilePageEdit/widgets/profile_text_container.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePageEdit extends StatefulWidget {
  ProfilePageEdit({super.key});
  final firstNameController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  Future<void> updateUser(BuildContext context, String firstName,
      String password, String lastName, String userName, String email) async {
    final userId = Provider.of<LoginProvider>(context, listen: false).userId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;
    final usersData = Provider.of<LoginProvider>(context, listen: false);
    final apiUrl =
        "https://app-production-7b68.up.railway.app/user-update/$userId/";
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Token $token',
        },
        body: jsonEncode({
          "first_name": firstName == "" ? usersData.firstName : firstName,
          "last_name": lastName == "" ? usersData.lastName : lastName,
          "email": email == "" ? usersData.userEmail : email,
          "username": userName == "" ? usersData.userName : userName,
          "current_password": password,
          "profile": {
            "profileAge": usersData.age,
            "profileGender": usersData.gender,
          },
        }),
      );

      if (response.statusCode == 200) {
        usersData.updateFields(firstName, lastName, userName, email);
        print('Response data: ${response.statusCode}');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // Handle other status codes

        print(token);
        print(usersData.profileId);
        // print(response.body);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPallete.highlightColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Personal Info",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            ProfileTextContainer(
              onTap: () {
                editShowAlertDialog("first Name", widget.firstNameController);
              },
              containerText: 'First Name: ${usersData.firstName}',
            ),
            SizedBox(
              height: 10,
            ),
            ProfileTextContainer(
                onTap: () {
                  editShowAlertDialog("last Name", widget.lastNameController);
                },
                containerText: "last Name: ${usersData.lastName}"),
            SizedBox(
              height: 10,
            ),
            ProfileTextContainer(
                onTap: () {
                  editShowAlertDialog("Username", widget.usernameController);
                },
                containerText: "Username: ${usersData.userName}"),
            SizedBox(
              height: 10,
            ),
            ProfileTextContainer(
              onTap: () {
                editShowAlertDialog("Email", widget.emailController);
              },
              containerText: "Email: ${usersData.userEmail}",
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 55,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(180, 22, 26, 30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Age: ${usersData.age}",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 55,
                  color: Colors.blue,
                  child: Icon(
                    Icons.edit_off,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 55,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(180, 22, 26, 30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: usersData.gender == "M"
                        ? Text(
                            "Gender: Male",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        : Text(
                            "Gender: Female",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 55,
                  color: Colors.blue,
                  child: Icon(
                    Icons.edit_off,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> editShowAlertDialog(
      String dataToBeEdited, dynamic controllerData) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit your profile"),
        content: TextWidgetField(
          hintText: dataToBeEdited,
          obscuretext: false,
          controller: controllerData,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("discard"),
          ),
          MaterialButton(
            onPressed: () {
              passwordShowAlertDialogBox();
              // if (controllerData.toString() == "") {
              //   print("null");
              // }
            },
            child: Text("Change"),
          )
        ],
      ),
    );
  }

  Future<void> passwordShowAlertDialogBox() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are your sure?"),
        content: TextWidgetField(
          hintText: "Enter password to confirm",
          obscuretext: true,
          controller: widget.passwordController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("discard"),
          ),
          MaterialButton(
            onPressed: () {
              // passwordShowAlertDialogBox();
              updateUser(
                  context,
                  widget.firstNameController.text,
                  widget.passwordController.text,
                  widget.lastNameController.text,
                  widget.usernameController.text,
                  widget.emailController.text);
            },
            child: Text("Change"),
          )
        ],
      ),
    );
  }
}
