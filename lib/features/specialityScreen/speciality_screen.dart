import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/features/homeScreen/widgets/doctors_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cure_health_app/core/provider/doctor_provider.dart';
import 'package:provider/provider.dart';

class SpecialityScreen extends StatefulWidget {
  final String specialityImage;
  final String specialityName;
  final String specialityData;
  final String speciality; // Add this line
  const SpecialityScreen({
    super.key,
    required this.specialityImage,
    required this.specialityName,
    required this.specialityData,
    required this.speciality, // Add this line
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
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          widget.specialityName,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: ColorPallete.highlightColor,
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, doctorProvider, child) {
          final specialityDoctors = doctorProvider.doctors
              .where((doctor) => doctor.doctorSpeciality == widget.speciality)
              .toList();
          return ListView(
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
                  ),
                  // Add this section to list doctors of the selected speciality
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: specialityDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = specialityDoctors[index];
                      return DoctorsCard(doctor: doctor);
                    },
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
