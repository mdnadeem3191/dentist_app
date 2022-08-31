// import 'package:dentist_app/screens/payment/failed_screen.dart';
// import 'package:dentist_app/screens/payment/payment_screen.dart';
// import 'package:dentist_app/widget/custom_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../../widget/date_time_appointment/reuse_date_container.dart';
// import '../../widget/date_time_appointment/reuse_time_container.dart';

// enum Week {
//   sunday,
//   monday,
//   tuesday,
//   wednesday,
//   thursday,
//   friday,
// }

// class Appointment extends StatefulWidget {
//   final double ratingStar;
//   const Appointment({Key? key, required this.ratingStar}) : super(key: key);

//   @override
//   State<Appointment> createState() => _AppointmentState();
// }

// class _AppointmentState extends State<Appointment> {

//   // TextEditingController controller = TextEditingController();
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();

//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_vfEoHpOIUZ0bYI',
//       'amount': 500 * 100,
//       'name': 'Highlark Dentist Service.',
//       'description': 'Pay your Dentist',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'prefill': {
//         'contact': '8448461402',
//         'email': FirebaseAuth.instance.currentUser!.email
//       },
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => PaymentScreen(response.paymentId!),
//         ),
//         (Route<dynamic> route) => false);
//     /*Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId!,
//         toastLength: Toast.LENGTH_SHORT); */
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => FailedScreen(response.code.toString()),
//     ));
//     /* Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//         toastLength: Toast.LENGTH_SHORT); */
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     /* Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!,
//         toastLength: Toast.LENGTH_SHORT); */
//   }


//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Choose your Slot"),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
//         ],
//         backgroundColor: Colors.teal,
        
//       ),
//     );
//     // Scaffold(
//     //   appBar: AppBar(
//     //     title: const Text("Choose your Slot"),
//     //     centerTitle: true,
//     //     elevation: 0,
//     //     actions: [
//     //       IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
//     //     ],
//     //     backgroundColor: Colors.teal,
//     //   ),
//     //   body: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       Container(
//     //         width: MediaQuery.of(context).size.width,
//     //         height: 150,
//     //         decoration: const BoxDecoration(
//     //             color: Colors.teal,
//     //             borderRadius: BorderRadius.only(
//     //                 bottomLeft: Radius.circular(30),
//     //                 bottomRight: Radius.circular(30))),
//     //         child: Row(
//     //           children: [
//     //             Image.asset('images/doctor.png',
//     //                 fit: BoxFit.fitHeight, alignment: Alignment.bottomLeft),
//     //             Column(
//     //               mainAxisAlignment: MainAxisAlignment.center,
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 const Text(
//     //                   "Dentist",
//     //                   style: TextStyle(
//     //                     fontSize: 35,
//     //                     fontWeight: FontWeight.w500,
//     //                     color: Colors.white,
//     //                   ),
//     //                 ),
//     //                 const SizedBox(
//     //                   height: 10,
//     //                 ),
//     //                 Container(
//     //                   padding: const EdgeInsets.symmetric(
//     //                       horizontal: 10, vertical: 5),
//     //                   decoration: BoxDecoration(
//     //                       color: const Color(0xffffc13b),
//     //                       borderRadius: BorderRadius.circular(15)),
//     //                   child: Row(
//     //                     mainAxisAlignment: MainAxisAlignment.start,
//     //                     children: [
//     //                       Text(
//     //                         "${widget.ratingStar}",
//     //                         style: const TextStyle(
//     //                             fontSize: 15,
//     //                             fontWeight: FontWeight.normal,
//     //                             color: Colors.white),
//     //                       ),
//     //                       const SizedBox(
//     //                         width: 3,
//     //                       ),
//     //                       const Icon(
//     //                         Icons.star,
//     //                         color: Colors.white,
//     //                         size: 18,
//     //                       )
//     //                     ],
//     //                   ),
//     //                 )
//     //               ],
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //       Container(
//     //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//     //         child: const Text(
//     //           "Aug 2022",
//     //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//     //         ),
//     //       ),
//     //       SizedBox(
//     //         height: 100,
//     //         child: ListView.builder(
//     //           scrollDirection: Axis.horizontal,
//     //           itemCount: 7,
//     //           itemBuilder: (context, index) {
//     //             return ReUseDateContainer(
//     //               day: DateFormat("EEEE"[3]).format(DateTime.now()),
//     //               date: DateFormat("dd").format(DateTime.now()),
//     //               isSelected: true,
//     //               onTap: () {},
//     //             );
//     //           },
//     //           // children: [
//     //           //   ReUseDateContainer(
//     //           //       date: DateFormat("dd").format(DateTime.now()),
//     //           //       day: "Mon",
//     //           //       isSelected: isTrue,
//     //           //       onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "22", day: "Tue", isSelected: isTrue, onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "23", day: "Wed", isSelected: isTrue, onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "24", day: "Thu", isSelected: isTrue, onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "25", day: "Fri", isSelected: isTrue, onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "26", day: "Sat", isSelected: isTrue, onTap: () {}),
//     //           //   ReUseDateContainer(
//     //           //       date: "27", day: "Sun", isSelected: isTrue, onTap: () {}),
//     //           // ],
//     //         ),
//     //       ),
//     //       Container(
//     //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//     //         child: const Text(
//     //           "Morning",
//     //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//     //         ),
//     //       ),
//     //       SizedBox(
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               children: const [
//     //                 ReUseTimeContainer(time: "08:00", isSelected: true),
//     //                 ReUseTimeContainer(time: "08:30", isSelected: true),
//     //                 ReUseTimeContainer(time: "09:00", isSelected: true)
//     //               ],
//     //             ),
//     //             const SizedBox(
//     //               height: 10,
//     //             ),
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               children: const [
//     //                 ReUseTimeContainer(time: "09:30", isSelected: true),
//     //                 ReUseTimeContainer(time: "10:00", isSelected: true),
//     //                 ReUseTimeContainer(time: "10:30", isSelected: true)
//     //               ],
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       Container(
//     //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//     //         child: const Text(
//     //           "Evening",
//     //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//     //         ),
//     //       ),
//     //       SizedBox(
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               children: const [
//     //                 ReUseTimeContainer(time: "07:00", isSelected: true),
//     //                 ReUseTimeContainer(time: "07:30", isSelected: true),
//     //                 ReUseTimeContainer(time: "08:00", isSelected: true)
//     //               ],
//     //             ),
//     //             const SizedBox(
//     //               height: 10,
//     //             ),
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               children: const [
//     //                 ReUseTimeContainer(time: "08:30", isSelected: true),
//     //                 ReUseTimeContainer(time: "09:00", isSelected: true),
//     //                 ReUseTimeContainer(time: "09:30", isSelected: true)
//     //               ],
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       const SizedBox(
//     //         height: 30,
//     //       ),
//     //       Padding(
//     //         padding: const EdgeInsets.symmetric(horizontal: 10),
//     //         child: CustomButton(
//     //             onTap: () {
//     //               openCheckout();
//     //             },
//     //             buttonWidth: MediaQuery.of(context).size.width,
//     //             buttonheight: 50,
//     //             color: const Color.fromARGB(255, 31, 123, 108),
//     //             elevation: 10,
//     //             child: const Text(
//     //               "Make an Appointment",
//     //               style: TextStyle(fontSize: 17),
//     //             )),
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
// }
