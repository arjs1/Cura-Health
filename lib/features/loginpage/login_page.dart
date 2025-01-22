import 'dart:convert';

import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/features/loginpage/widgets/text_widget_field.dart';
import 'package:cure_health_app/features/signupPage/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  final apiUrl = "https://expressnews-production.up.railway.app/user-create/";
  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  Future<void> getResponse(String username, String password) async {
    final uri = Uri.parse(apiUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      for (var user in responseData) {
        // print("ID: ${user['id']}");
        print("Username: ${user['username']}");
        print("Email: ${user['email']}");
        print("password: ${user['password']}");

        // Add more fields as necessary
      }
    } else {
      print("Unsuccessful: ${response.statusCode}");
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
