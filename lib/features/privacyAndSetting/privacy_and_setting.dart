import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:cure_health_app/features/profilePage/widget/profile_tablet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PrivacyAndSetting extends StatefulWidget {
  const PrivacyAndSetting({super.key});

  @override
  State<PrivacyAndSetting> createState() => _PrivacyAndSettingState();
}

class _PrivacyAndSettingState extends State<PrivacyAndSetting> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallete.highlightColor,
        title: Text(
          'Privacy and Setting',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: 20,
            ),
            ProfileTablet(
              onTap: () {},
              tabName: "Change Password",
            ),
            ProfileTablet(
                onTap: () {
                  deleteUser(context);
                },
                tabName: "delete Account"),
          ],
        ),
      ),
    );
  }
}
