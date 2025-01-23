import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileTablet extends StatefulWidget {
  void Function()? onTap;
  final String tabName;
  ProfileTablet({
    super.key,
    required this.onTap,
    required this.tabName,
  });

  @override
  State<ProfileTablet> createState() => _ProfileTabletState();
}

class _ProfileTabletState extends State<ProfileTablet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 7,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          child: Center(
            child: Text(
              textAlign: TextAlign.start,
              widget.tabName.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorPallete.tabColor,
                letterSpacing: 4.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
