import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String dentistName;
  String dentistAddress;
  Timestamp date;
  String time;
  String paymentId;

  AppointmentModel({
    required this.dentistName,
    required this.dentistAddress,
    required this.date,
    required this.time,
    required this.paymentId,
  });
}
