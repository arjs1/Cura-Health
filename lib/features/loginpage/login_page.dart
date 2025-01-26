import 'dart:convert';

import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:cure_health_app/features/homeScreen/home_page.dart';
import 'package:cure_health_app/core/constant/home_screen.dart';
import 'package:cure_health_app/features/loginpage/widgets/text_widget_field.dart';
import 'package:cure_health_app/features/signupPage/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final apiUrl = "https://app-production-7b68.up.railway.app/user-login/";

  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  Future<void> loginUser(
    BuildContext context,
    String username,
    String password,
  ) async {
    final uri = Uri.parse(apiUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        // "email": email,
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final token = responseBody['token'];

      final user = responseBody['user'];
      final id = user['id'];
      final userName = user['username'];
      final userEmail = user['email'];
      final firstName = user['first_name'];
      final lastName = user['last_name'];
      final profile = user['profile'];
      final gender = profile['profileGender'];
      final profileId = profile['profileID'];
      final age = profile['profileAge'];
      print(response.body);

      // Access the LoginProvider and set the token
      Provider.of<LoginProvider>(context, listen: false).setToken(token, id,
          userName, userEmail, firstName, lastName, gender, profileId, age);
      fetchData(context);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      // Add more fields as necessary
    } else {
      print("Unsuccessful: ${response.body}");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
    }
  }

  Future<void> fetchData(BuildContext context) async {
    final url =
        Uri.parse('https://app-production-7b68.up.railway.app/test-token/');
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;

    try {
      final response = await http.get(
        url,
        headers: {
          //  "Content-Type": "application/json"
          "Authorization": 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        // Successfully received response
        print('Response data: ${response.body}');
      } else {
        // Handle other status codes
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print('An error occurred: $e');
    }
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: BoxDecoration(
                color: ColorPallete.primaryColor,
                image: DecorationImage(
                    opacity: 0.3,
                    image: AssetImage("assets/images/login.avif"),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text(
                "Welcome To Cure Health".toUpperCase(),
                style: GoogleFonts.poppins(
                  color: ColorPallete.tabColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    //username
                    TextWidgetField(
                      hintText: 'Username',
                      obscuretext: false,
                      controller: widget.usernamecontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //password
                    TextWidgetField(
                      controller: widget.passwordcontroller,
                      hintText: "password",
                      obscuretext: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //submit button

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
                            // widget.getResponse(widget.usernamecontroller.text,
                            //     widget.passwordcontroller.text);

                            if (widget.usernamecontroller.text == "" &&
                                widget.passwordcontroller.text == "") {
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
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              widget.loginUser(
                                  context,
                                  widget.usernamecontroller.text,
                                  widget.passwordcontroller.text);
                            }
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                                color: ColorPallete.tabColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Doesnot have an account?",
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
