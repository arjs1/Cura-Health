import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextContainer extends StatefulWidget {
  void Function()? onTap;
  final String containerText;
  ProfileTextContainer(
      {super.key, required this.onTap, required this.containerText});

  @override
  State<ProfileTextContainer> createState() => _ProfileTextContainerState();
}

class _ProfileTextContainerState extends State<ProfileTextContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 1.5,
          height: 55,
          // color: Colors.amber,
          decoration:
              BoxDecoration(color: const Color.fromARGB(180, 22, 26, 30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.containerText,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 55,
            color: Colors.blue,
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
