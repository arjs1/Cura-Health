import 'dart:convert';
import 'package:cure_health_app/features/loginpage/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/features/loginpage/widgets/text_widget_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _selectedGender = 'male';
  final apiUrl = "https://app-production-7b68.up.railway.app/user-create/";

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future<void> getResponse(String firstName, String lastName, String username,
      String password, String email, int age, String gender) async {
    final uri = Uri.parse(apiUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "username": username,
          "email": email,
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
          "profile": {"profileAge": age, "profileGender": gender}
        },
      ),
      // 0<age<120
      // M- Male F-Female
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print("ID: ${responseData['id']}");
      print("ID: ${responseData['first_name']}");
      print("ID: ${responseData['last_name']}");

      print("Username: ${responseData['username']}");
      print("Email: ${responseData['email']}");
      print("password: ${responseData['password']}");
      print("password: ${responseData['age']}");

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      // Add more fields as necessary
    } else {
      print("Unsuccessful: ${response.body}");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.3,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/signup.webp",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 40,
              ),
            ),
          ),
          Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To Cure Health".toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: ColorPallete.tabColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextWidgetField(
                          hintText: "first name",
                          obscuretext: false,
                          controller: firstNameController),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextWidgetField(
                          hintText: "last name",
                          obscuretext: false,
                          controller: lastNameController),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      'Male',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                    Radio<String>(
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Text(
                      'Female',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                TextWidgetField(
                    hintText: "Age",
                    obscuretext: false,
                    controller: ageController),
                TextWidgetField(
                    hintText: "email",
                    obscuretext: false,
                    controller: emailController),
                TextWidgetField(
                  hintText: "username",
                  obscuretext: false,
                  controller: usernameController,
                ),
                TextWidgetField(
                  hintText: "password",
                  obscuretext: true,
                  controller: passwordController,
                ),
                TextWidgetField(
                  hintText: "confirm password",
                  obscuretext: true,
                  controller: confirmPasswordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorPallete.secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: MaterialButton(
                      onPressed: () {
                        if (usernameController.text == "" &&
                            passwordController.text == "" &&
                            confirmPasswordController.text == "") {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                "Please Enter username & password",
                                style: GoogleFonts.poppins(),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    color: ColorPallete.highlightColor,
                                    padding: const EdgeInsets.all(14),
                                    child: Text(
                                      "okay",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (confirmPasswordController.text ==
                            passwordController.text) {
                          if (_selectedGender == "male") {
                            getResponse(
                                firstNameController.text,
                                lastNameController.text,
                                usernameController.text,
                                passwordController.text,
                                emailController.text,
                                int.parse(ageController.text),
                                "M");
                          } else {
                            getResponse(
                              firstNameController.text,
                              lastNameController.text,
                              usernameController.text,
                              passwordController.text,
                              emailController.text,
                              int.parse(ageController.text),
                              "F",
                            );
                          }
                        } else {
                          //
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text(
                                      "Password doesnot match",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          color: ColorPallete.highlightColor,
                                          padding: const EdgeInsets.all(14),
                                          child: Text(
                                            "okay",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: Text(
                        "Signup",
                        style: GoogleFonts.poppins(
                            color: ColorPallete.tabColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
