import 'dart:convert';

import 'package:cure_health_app/features/homeScreen/model/doctor_model.dart';
import 'package:http/http.dart' as http;

class ApiFetchDoctorData {
  Future<List<DoctorModel>> getDoctors() async {
    const apiUrl = "https://app-production-7b68.up.railway.app/doctors/";

    final uri = Uri.parse(apiUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<DoctorModel> doctors =
          data.map((e) => DoctorModel.fromJson(e)).toList();
      return doctors;
    } else {
      print(response.body);
      throw Exception('Failed to load doctors');
    }
  }
}
