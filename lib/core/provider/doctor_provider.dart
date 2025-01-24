import 'package:cure_health_app/core/api/api_fetch_doctor_data.dart';
import 'package:cure_health_app/features/homeScreen/model/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorProvider with ChangeNotifier {
  final _doctorsData = ApiFetchDoctorData();
  List<DoctorModel> _doctors = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<DoctorModel> get doctors => _doctors;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDoctors() async {
    _isLoading = true;
    notifyListeners();
    try {
      _doctors = await _doctorsData.getDoctors();
      _errorMessage = null;
    } catch (error) {
      print(error.toString());
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<DoctorModel> searchDoctors(String query) {
    return _doctors.where((doctor) {
      final nameLower = doctor.doctorName.toLowerCase();
      final searchLower = query.toLowerCase();
      final specialityLower = doctor.doctorSpeciality.toLowerCase();
      return nameLower.contains(searchLower) ||
          specialityLower.contains(searchLower);
    }).toList();
  }
}
