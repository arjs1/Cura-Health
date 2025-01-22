import 'package:carousel_slider/carousel_slider.dart';
import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/utilis/Speciality_doctor_model_data.dart';
import 'package:cure_health_app/features/homeScreen/widgets/carousel_widget.dart';
import 'package:cure_health_app/features/homeScreen/widgets/top_bar_widget.dart';
import 'package:cure_health_app/features/specialityScreen/speciality_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            //----> Top Bar Widget <-----//
            TopBarWidget(),
            SizedBox(
              height: 15,
            ),
            //----> Speciality of doctors <-----//

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Specialty",
                  style: GoogleFonts.poppins(
                      color: ColorPallete.tabColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "see all",
                    style: GoogleFonts.poppins(
                        color: ColorPallete.highlightColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            CarouselSlider.builder(
              itemCount: 4,
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecialityScreen(
                        specialityImage:
                            specialitydata[itemIndex].specialityImage,
                        specialityName:
                            specialitydata[itemIndex].specialityName,
                        specialityData:
                            specialitydata[itemIndex].specialityRequirement,
                      ),
                    ),
                  );
                },
                child: CarouselWidget(
                  doctorImagePath: specialitydata[itemIndex].specialityImage,
                  doctorImageText: specialitydata[itemIndex].specialityName,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
