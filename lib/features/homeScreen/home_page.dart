import 'package:carousel_slider/carousel_slider.dart';
import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/doctor_provider.dart';
import 'package:cure_health_app/core/utilis/Speciality_doctor_model_data.dart';
import 'package:cure_health_app/features/DetailPage/detail_page.dart';
import 'package:cure_health_app/features/allspecialityPage/all_speciality_page.dart';
import 'package:cure_health_app/features/homeScreen/widgets/carousel_widget.dart';
import 'package:cure_health_app/features/homeScreen/widgets/top_bar_widget.dart';
import 'package:cure_health_app/features/specialityScreen/speciality_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallete.primaryColor,
        body: Consumer<DoctorProvider>(
          builder: (context, doctorProvider, child) {
            if (doctorProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (doctorProvider.errorMessage != null) {
              return Center(
                child: Text('Error: ${doctorProvider.errorMessage}'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllSpecialityPage()));
                            },
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
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
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
                                  specialityData: specialitydata[itemIndex]
                                      .specialityRequirement,
                                  speciality: specialitydata[itemIndex]
                                      .specialityName, // Add this line
                                ),
                              ),
                            );
                          },
                          child: CarouselWidget(
                            doctorImagePath:
                                specialitydata[itemIndex].specialityImage,
                            doctorImageText:
                                specialitydata[itemIndex].specialityName,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //----> Top Doctor <-----//
                      Text(
                        "Top Doctor".toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: ColorPallete.tabColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width,

                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doctorProvider.doctors.length,
                          itemBuilder: (BuildContext context, int index) {
                            final doctor = doctorProvider.doctors[index];
                            return SizedBox(
                              height: 200,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.8,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://app-production-7b68.up.railway.app${doctor.doctorImagePath}",
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              color:
                                                  ColorPallete.highlightColor,
                                              child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPage(
                                                        doctorId:
                                                            doctor.doctorId,
                                                        doctorExperience: doctor
                                                            .doctorExperience,
                                                        doctorImagePath: doctor
                                                            .doctorImagePath,
                                                        doctorName:
                                                            doctor.doctorName,
                                                        doctorQualification: doctor
                                                            .doctorQualification,
                                                        doctorSpeciality: doctor
                                                            .doctorSpeciality,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Book An Appointment",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorPallete
                                                        .secondaryColor,
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
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
