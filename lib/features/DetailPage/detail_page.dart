import 'dart:convert';

import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/doctor_provider.dart';
import 'package:cure_health_app/core/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  Future<void> createAppointment(String dateTime) async {
    final profileIdData =
        Provider.of<LoginProvider>(context, listen: false).profileId;
    final token = Provider.of<LoginProvider>(context, listen: false).authToken;
    final usersData = Provider.of<LoginProvider>(context, listen: false);
    final doctorId = widget.doctorId;
    final status = "scheduled";
    final apiUrl =
        "https://app-production-7b68.up.railway.app/appointments/create/";
    final url = Uri.parse(apiUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Token $token',
        },
        body: jsonEncode({
          "userProfile": profileIdData,
          "doctor": doctorId,
          "appointmentDateTime": dateTime,
          "status": status,
        }),
      );

      if (response.statusCode == 201) {
        // usersData.updateFields(firstName, lastName, userName, email);
        print('Response data: ${response.body}');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // Handle other status codes

        print(token);
        print(dateTime);
        print(response.body);
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      print(widget.doctorId);
      print(dateTime);
      print(profileIdData);

      print('An error occurred: $e');
    }
  }

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
          children: [
            DetailCard(widget: widget),
            ElevatedButton(
              onPressed: () {
                // dateTimePickerWidget(context);
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                ).then((selectedDate) {
                  // After selecting the date, display the time picker.
                  if (selectedDate != null) {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      // Handle the selected date and time here.
                      // if (selectedTime != null) {
                      //   DateTime selectedDateTime = DateTime(
                      //     selectedDate.year,
                      //     selectedDate.month,
                      //     selectedDate.day,
                      //     selectedTime.hour,
                      //     selectedTime.minute,
                      //   );
                      //   String formattedTime = DateFormat("yyyy-MM-ddTHH:mm:ss'Z'")
                      //       .format(selectedTime.toUtc());

                      //   print(
                      //       selectedDateTime); // You can use the selectedDateTime as needed.
                      // }
                      if (selectedTime != null) {
                        DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        String formattedTime =
                            DateFormat("yyyy-MM-ddTHH:mm:ss'Z'")
                                .format(selectedDateTime.toUtc());

                        print(formattedTime); // Output the formatted time
                        createAppointment(
                            formattedTime); // You can use the selectedDateTime as needed.
                      }
                    });
                  }
                });
              },
              child: Text('Pick Date-Time'),
            ),
          ],
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
    return Column(
      children: [
        Card(
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
        ),
      ],
    );
  }

  // dateTimePickerWidget(BuildContext context) {
  //   return DatePicker.showDatePicker(
  //     context,
  //     dateFormat: 'dd MMMM yyyy HH:mm',
  //     initialDateTime: DateTime.now(),
  //     minDateTime: DateTime(2000),
  //     maxDateTime: DateTime(3000),
  //     onMonthChangeStartWithFirstDate: true,
  //     onConfirm: (dateTime, List<int> index) {
  //       DateTime selectdate = dateTime;
  //       String formattedTime =
  //           DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(selectdate.toUtc());
  //       final selIOS = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);

  //       print(formattedTime);
  //     },
  //   );
  // }
}
