class DoctorModel {
  final String doctorId;
  final String doctorImagePath;
  final String doctorSpeciality;
  final String doctorName;
  final String doctorExperience;
  final String doctorQualification;

  DoctorModel({
    required this.doctorId,
    required this.doctorExperience,
    required this.doctorImagePath,
    required this.doctorName,
    required this.doctorQualification,
    required this.doctorSpeciality,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      doctorSpeciality: json['doctorSpeciality'],
      doctorExperience: json['doctorExperience'],
      doctorQualification: json['doctorQualification'],
      doctorImagePath: json['doctorImage'],
    );
  }
}
