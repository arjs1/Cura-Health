import 'package:cure_health_app/core/constant/capitalize_data.dart';
import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String firstnameData =
        Provider.of<LoginProvider>(context, listen: false).firstName.toString();
    String lastnameData =
        Provider.of<LoginProvider>(context, listen: false).lastName.toString();
    String genderData =
        Provider.of<LoginProvider>(context, listen: false).gender.toString();
    final ageData = Provider.of<LoginProvider>(context, listen: false).age;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.amber,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$firstnameData ".toTitleCase + "$lastnameData".toTitleCase,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: ColorPallete.tabColor,
                        fontWeight: FontWeight.w500),
                  ),
                  genderData == "M"
                      ? Text(
                          "Male, ${ageData}",
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 139, 139, 139),
                          ),
                        )
                      : Text(
                          "Female, ${ageData}",
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 139, 139, 139),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
