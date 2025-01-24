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
  final changePasswordController = TextEditingController();
  final reconfirmPasswordController = TextEditingController();
  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  Future<void> updateUser(BuildContext context, String firstName,
      String password, String lastName, String userName, String email) async {
    final id = Provider.of<LoginProvider>(context, listen: false).userId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;
    final usersData = Provider.of<LoginProvider>(context, listen: false);
    final apiUrl =
        "https://app-production-7b68.up.railway.app/user-update/$id/";
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
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        usersData.updateFields(firstName, lastName, userName, email);
        print('Response data: ${response.body}');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // Handle other status codes

        print(token);
        print(id);
        print(response.body);
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
            // Text(usersData.firstName ?? ""),
            // Text(usersData.lastName ?? ""),
            // Text(usersData.userEmail ?? ""),
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
                containerText: "Email: ${usersData.userEmail}"),
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
