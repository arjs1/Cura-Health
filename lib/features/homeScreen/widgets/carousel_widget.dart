import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselWidget extends StatelessWidget {
  final String doctorImagePath;
  final String doctorImageText;
  const CarouselWidget(
      {super.key,
      required this.doctorImagePath,
      required this.doctorImageText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              // imageList[itemIndex],
              doctorImagePath),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: ColorPallete.highlightColor,
            child: Text(
              doctorImageText.toUpperCase(),
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
