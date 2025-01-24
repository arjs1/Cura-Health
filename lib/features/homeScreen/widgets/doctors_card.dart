import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/features/DetailPage/detail_page.dart';
import 'package:cure_health_app/features/homeScreen/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsCard extends StatelessWidget {
  const DoctorsCard({
    super.key,
    required this.doctor,
  });

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  height: 200,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://app-production-7b68.up.railway.app${doctor.doctorImagePath}",
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      doctor.doctorName.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: ColorPallete.tabColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      doctor.doctorSpeciality,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      doctor.doctorQualification,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 40,
                      color: ColorPallete.highlightColor,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                doctorId: doctor.doctorId,
                                doctorImagePath: doctor.doctorImagePath,
                                doctorName: doctor.doctorName,
                                doctorExperience: doctor.doctorExperience,
                                doctorQualification: doctor.doctorQualification,
                                doctorSpeciality: doctor.doctorSpeciality,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Book An Appointment",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: ColorPallete.secondaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
