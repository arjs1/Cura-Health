import 'package:cure_health_app/core/constant/color_pallete.dart';
import 'package:cure_health_app/core/provider/doctor_provider.dart';
// import 'package:cure_health_app/core/utilis/Speciality_doctor_model_data.dart';
import 'package:cure_health_app/features/DetailPage/detail_page.dart';
import 'package:cure_health_app/features/homeScreen/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<DoctorModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);

    return Scaffold(
      backgroundColor: ColorPallete.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorPallete.highlightColor,
        leading: Icon(
          Icons.search,
          size: 30,
          color: Colors.white,
        ),
        title: TextField(
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            focusColor: Colors.white,
            hintText: 'Search by speciality or doctor\'s name',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            setState(() {
              query = value;
              searchResults = doctorProvider.searchDoctors(query);
            });
          },
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final doctor = searchResults[index];
          return Card(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                        doctorId: doctor.doctorId,
                        doctorExperience: doctor.doctorExperience,
                        doctorImagePath: doctor.doctorImagePath,
                        doctorName: doctor.doctorName,
                        doctorQualification: doctor.doctorQualification,
                        doctorSpeciality: doctor.doctorSpeciality),
                  ),
                );
              },
              child: ListTile(
                leading: Image.network(
                    width: 50,
                    height: 100,
                    fit: BoxFit.cover,
                    "https://app-production-7b68.up.railway.app${doctor.doctorImagePath}"),
                title: Text(doctor.doctorName),
                subtitle: Text(doctor.doctorSpeciality),
              ),
            ),
          );
        },
      ),
    );
  }
}
