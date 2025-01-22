import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialityScreen extends StatefulWidget {
  final String specialityImage;
  final String specialityName;
  final String specialityData;
  const SpecialityScreen({
    super.key,
    required this.specialityImage,
    required this.specialityName,
    required this.specialityData,
  });

  @override
  State<SpecialityScreen> createState() => _SpecialityScreenState();
}

class _SpecialityScreenState extends State<SpecialityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      appBar: AppBar(
        title: Text(
          widget.specialityName,
          style: GoogleFonts.poppins(),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: ClipRRect(
                  child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.specialityImage)),
                ),
              ),
              Card(
                elevation: 4,
                color: ColorPallete.secondaryColor,
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.specialityData,
                    style: GoogleFonts.poppins(
                      wordSpacing: 1.5,
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
