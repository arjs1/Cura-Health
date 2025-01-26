import 'dart:convert';

import 'package:cure_health_app/core/constant/capitalize_data.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/features/appointmentPage/appointment_page.dart';
import 'package:cure_health_app/features/privacyAndSetting/privacy_and_setting.dart';
import 'package:cure_health_app/features/profilePage/widget/image_data.dart';
import 'package:cure_health_app/features/profilePage/widget/profile_tablet.dart';
import 'package:cure_health_app/features/profilePage/profilePageEdit/profile_page_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> deleteUser(BuildContext context) async {
    final id = Provider.of<LoginProvider>(context, listen: false).userId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;

    final apiUrl =
        "https://app-production-7b68.up.railway.app/user-delete/$id/";
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.delete(
        url,
        headers: {
          //  "Content-Type": "application/json"
          "Authorization": 'Token $token',
        },
      );

      if (response.statusCode == 204) {
        // Successfully received response

        print('Response data: ${response.body}');
        Navigator.pop(context);
      } else {
        // Handle other status codes
        final token =
            Provider.of<LoginProvider>(context, listen: false).authToken;
        print(token);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print('An error occurred: $e');
    }
  }

  Future<void> viewAppointment(BuildContext context) async {
    final profileIdData =
        Provider.of<LoginProvider>(context, listen: false).profileId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;
    final usersData = Provider.of<LoginProvider>(context, listen: false);

    final apiUrl =
        "https://app-production-7b68.up.railway.app/user-appointments/$profileIdData/";
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Token $token',
        },
        body: jsonEncode({}),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AppointmentPage(appointmentData: responseData),
          ),
        );
      } else {
        // Handle other status codes
        print(token);
        print(response.body);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print(profileIdData);
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<LoginProvider>(context).userName;
    final firstName = Provider.of<LoginProvider>(context).firstName;
    final lastName = Provider.of<LoginProvider>(context).lastName;
    final userEmail = Provider.of<LoginProvider>(context).userEmail;

    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      body: Center(
        child: ListView(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.amber,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "$firstName $lastName".toTitleCase,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                spacing: 30,
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  ProfileTablet(
                    onTap: () {
                      viewAppointment(context);
                    },
                    tabName: "Your appointment",
                  ),
                  ProfileTablet(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePageEdit(),
                        ),
                      );
                    },
                    tabName: "personal info",
                  ),
                  ProfileTablet(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyAndSetting()));
                    },
                    tabName: "privacy & setting",
                  ),
                  ProfileTablet(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    tabName: "logout",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
