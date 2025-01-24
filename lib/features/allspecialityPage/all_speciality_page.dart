import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/utilis/Speciality_doctor_model_data.dart';
import 'package:cure_health_app/features/homeScreen/widgets/carousel_widget.dart';
import 'package:cure_health_app/features/specialityScreen/speciality_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllSpecialityPage extends StatefulWidget {
  const AllSpecialityPage({super.key});

  @override
  State<AllSpecialityPage> createState() => _AllSpecialityPageState();
}

class _AllSpecialityPageState extends State<AllSpecialityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPallete.highlightColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Speciality",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: specialitydata.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpecialityScreen(
                                specialityImage:
                                    specialitydata[index].specialityImage,
                                specialityName:
                                    specialitydata[index].specialityName,
                                specialityData:
                                    specialitydata[index].specialityRequirement,
                                speciality:
                                    specialitydata[index].specialityName,
                              )));
                },
                child: CarouselWidget(
                    doctorImagePath: specialitydata[index].specialityImage,
                    doctorImageText: specialitydata[index].specialityName),
              ),
            ),
          );
        },
      ),
    );
  }
}
