import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final String doctorId;
  final String doctorImagePath;
  final String doctorSpeciality;
  final String doctorName;
  final String doctorExperience;
  final String doctorQualification;

  const DetailPage({
    super.key,
    required this.doctorId,
    required this.doctorExperience,
    required this.doctorImagePath,
    required this.doctorName,
    required this.doctorQualification,
    required this.doctorSpeciality,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallete.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorPallete.highlightColor,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Details",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: ListView(
          children: [DetailCard(widget: widget)],
        ));
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    required this.widget,
  });

  final DetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Container(
              width: 180,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://app-production-7b68.up.railway.app${widget.doctorImagePath}"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.doctorName,
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.doctorSpeciality,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.doctorQualification.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Experience: ${widget.doctorExperience} Years",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
