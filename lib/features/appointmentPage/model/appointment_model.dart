class AppointmentModel {
  final String appointmentId;
  final String appointmentDateTime;
  final String appointmentStatus;
  final String userProfile;
  final String doctorId;

  AppointmentModel({
    required this.appointmentId,
    required this.appointmentDateTime,
    required this.appointmentStatus,
    required this.userProfile,
    required this.doctorId,
  });
}
