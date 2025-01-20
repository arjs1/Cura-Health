import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgetField extends StatefulWidget {
  final String hintText;
  final bool obscuretext;
  final controller;
  const TextWidgetField({
    super.key,
    required this.hintText,
    required this.obscuretext,
    required this.controller,
  });

  @override
  State<TextWidgetField> createState() => _TextWidgetFieldState();
}

class _TextWidgetFieldState extends State<TextWidgetField> {
  bool isSetIcon = false;
  void setIcondata() {
    setState(() {
      isSetIcon = !isSetIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isSetIcon ? widget.obscuretext : false,
        cursorWidth: 2,
        cursorColor: Colors.white,
        style: GoogleFonts.poppins(color: ColorPallete.secondaryColor),
        decoration: widget.obscuretext
            ? InputDecoration(
                hintText: widget.hintText,
                suffixIcon: IconButton(
                  onPressed: () {
                    setIcondata();
                  },
                  icon: isSetIcon
                      ? Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                ),
                hintStyle: GoogleFonts.poppins(
                  color: ColorPallete.secondaryColor,
                ),
                fillColor: ColorPallete.highlightColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              )
            : InputDecoration(
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: ColorPallete.secondaryColor,
                ),
                fillColor: ColorPallete.highlightColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
      ),
    );
  }
}
