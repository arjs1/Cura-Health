import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/doctor_provider.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  final List<dynamic> appointmentData;

  const AppointmentPage({super.key, required this.appointmentData});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  Future<void> deleteAppointment(String appointmentId) async {
    final id = Provider.of<LoginProvider>(context, listen: false).userId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;

    final apiUrl =
        "https://app-production-7b68.up.railway.app/appointments/$appointmentId/delete/";
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.delete(
        url,
        headers: {
          //  "Content-Type": "application/json"
          "Authorization": 'Token $token',
        },
      );

      if (response.statusCode == 204) {
        // Successfully received response
        setState(() {
          widget.appointmentData.removeWhere(
              (appointment) => appointment['appointmentId'] == appointmentId);
        });
        print('appointment deleted');
      } else {
        // Handle other status codes
        final token =
            Provider.of<LoginProvider>(context, listen: false).authToken;
        print(token);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print('An error occurred: $e');
    }
  }

  //appointmentid/delete
  @override
  Widget build(BuildContext context) {
    final doctorData = Provider.of<DoctorProvider>(context);

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
          "Appointment",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: widget.appointmentData.length,
        itemBuilder: (context, index) {
          final appointment = widget.appointmentData[index];
          final doctor = doctorData.doctors.firstWhere(
            (doc) => doc.doctorId == appointment['doctor'],
          );

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
                            "Date: ${appointment['appointmentDateTime']}",
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                color: ColorPallete.highlightColor,
                                child: Center(
                                  child: Text(
                                    "${appointment['status']}".toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: ColorPallete.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  deleteAppointment(
                                    appointment['appointmentId'],
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  color: ColorPallete.highlightColor,
                                  child: Center(
                                    child: Text(
                                      "Delete".toUpperCase(),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: ColorPallete.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
