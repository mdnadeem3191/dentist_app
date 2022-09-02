import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentist_app/models/appointment.dart';
import 'package:dentist_app/widget/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YourAppointment extends StatefulWidget {
  const YourAppointment({Key? key}) : super(key: key);

  @override
  State<YourAppointment> createState() => _YourAppointmentState();
}

class _YourAppointmentState extends State<YourAppointment> {
  final List<AppointmentModel> appointmentList = [];

  // String? dentistName;
  void deleteAppointment(String paymentId, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content:
              const Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('appointments')
                      .doc(paymentId)
                      .delete();
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const YourAppointment()),
                        (route) => false);
                  });
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      },
    );
  }

  Future<List<AppointmentModel>> getAppointments() async {
    QuerySnapshot<Map<String, dynamic>> appointments = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('appointments')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> appointment
        in appointments.docs) {
      appointmentList.add(AppointmentModel(
          dentistName: appointment['dentistName'],
          dentistAddress: appointment['dentistAddress'],
          date: appointment['date'],
          time: appointment['time'],
          paymentId: appointment['paymentId']));
    }

    return appointmentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text("Your Appointment"),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  "images/dentist.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: FutureBuilder(
                    future: getAppointments(),
                    builder: (context,
                        AsyncSnapshot<List<AppointmentModel>> appointments) {
                      return appointments.connectionState ==
                              ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: appointmentList.length,
                              itemBuilder: (context, index) {
                                return appointmentList.isEmpty
                                    ? const Center(
                                        child: Text(
                                          "No Appointment yet",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25),
                                        ),
                                      )
                                    : Card(
                                        elevation: 10,
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        child: Container(
                                            height: 230,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  appointmentList[index]
                                                      .dentistName,
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  appointmentList[index]
                                                      .dentistAddress,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          DateFormat('yMMMd',
                                                                  'en_US')
                                                              .format(
                                                                  appointmentList[
                                                                          index]
                                                                      .date
                                                                      .toDate()),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          appointmentList[index]
                                                              .time
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ],
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          deleteAppointment(
                                                              appointmentList[
                                                                      index]
                                                                  .paymentId,
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "Cancel Appointment",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      188,
                                                                      24,
                                                                      12)),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            )),
                                      );
                              },
                            );
                    }),
              ),
            ],
          ),
        ));
  }
}
