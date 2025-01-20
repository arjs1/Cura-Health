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
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                          print("true");
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
