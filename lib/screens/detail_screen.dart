import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentist_app/screens/payment/failed_screen.dart';
import 'package:dentist_app/screens/payment/successful_screen.dart';
import 'package:dentist_app/widget/date_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../models/lat_lng.dart';
import '../services/google_maps._service.dart';
import '../widget/google_map.dart';
import '../widget/star_widget.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String address;

  final double ratingStar;
  final int totalReviews;

  final String placeId;
  final String phoneNumber;

  const DetailScreen({
    Key? key,
    required this.name,
    required this.address,
    required this.ratingStar,
    required this.totalReviews,
    required this.placeId,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GoogleMapsService googleMapsService = GoogleMapsService();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_vfEoHpOIUZ0bYI',
      'amount': 500 * 100,
      'name': 'Highlark Dentist Service.',
      'description': 'Pay your Dentist',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '8448461402',
        'email': FirebaseAuth.instance.currentUser!.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  bool isLoading = false;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('appointments')
        .doc(response.paymentId)
        .set({
      'dentistName': widget.name,
      'dentistAddress': widget.address,
      'date': _selectedDate,
      'time': _selectedTime.format(context),
      'paymentId': response.paymentId
    });

    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => PaymentScreen(response.paymentId!),
          ),
          (Route<dynamic> route) => false);
    });

    setState(() {
      isLoading = false;
    });
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => FailedScreen(response.code.toString()),
        ),
        (Route<dynamic> route) => false);

    setState(() {
      isLoading = false;
    });

    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day + 1),
      firstDate: DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day + 1),
      lastDate: DateTime(
          _selectedDate.year, _selectedDate.month, _selectedDate.day + 7),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {
          setState(
            () {
              _selectedDate = pickedDate;
            },
          );
        }
      },
    );
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _selectedTime,
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      } else {
        setState(() {
          _selectedTime = pickedTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;
    double height9 = MediaQuery.of(context).size.height / 89.744; //h9.5

    return Scaffold(
      backgroundColor: const Color(0xff9edcf0),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Processing your Payment'),
                  SizedBox(height: 25),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                    ),
                    Positioned(
                      child: SizedBox(
                        height: height50 * 6,
                        width: double.infinity,
                        child: Image.asset("images/book2.webp",
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    Positioned(
                      top: height20 + height15,
                      left: height20 / 2,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black.withOpacity(0.3),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: height20 / 2,
                        ),
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: height20 / 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.white,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: height15 / 3),
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: height20,
                                    left: height20 / 2,
                                    right: height20 / 2),
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: height48 / 4,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: height9),
                                child: Text(
                                  widget.address,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: height50 / 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: height20 / 2),
                                    child: Row(
                                      children: [
                                        IconTheme(
                                          data: const IconThemeData(
                                            color: Color.fromARGB(
                                                255, 244, 199, 36),
                                            size: 22,
                                          ),
                                          child: StarDisplay(
                                              value: widget.ratingStar),
                                        ),
                                        SizedBox(
                                          width: height15 / 3,
                                        ),
                                        Text(
                                          "(${widget.totalReviews} reviews)",
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "See all reviews",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.payment_sharp),
                                          SizedBox(
                                            width: height20 / 2,
                                          ),
                                          const Text(
                                            "Online Payment  Available",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height48 / 6,
                                      ),
                                      Row(children: [
                                        SizedBox(
                                          width: height20 + height15,
                                        ),
                                        const Text(
                                          "₹ 500",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Color.fromARGB(
                                                  255, 36, 168, 41),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(width: height15 * 2),
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: height50,
                                          child: Image.asset("images/map.png")),
                                      SizedBox(
                                        height: height15,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            LatLngModel latlng =
                                                await googleMapsService
                                                    .getLatLng(widget.placeId);
                                            Future.delayed(Duration.zero, () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GoogleMapWidget(
                                                    latitude: latlng.latitude,
                                                    longitude: latlng.longitude,
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                          child: const Text("See on map")),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: height15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Opening hours",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: height15,
                                        ),
                                        const Text(
                                          "Mon-Fri  9 am - 6pm",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Sat-Sun  10am - 5pm",
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height20),
                              const Text(
                                "Select Date & Time",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: height20 / 4),
                              Container(
                                padding: EdgeInsets.only(
                                    right: height20, left: height20 / 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: DateWidget(
                                          selectedDate: DateTime(
                                              _selectedDate.year,
                                              _selectedDate.month,
                                              _selectedDate.day + 1)),
                                      onTap: () {
                                        _presentDatePicker();
                                      },
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          _presentTimePicker();
                                        },
                                        child: Chip(
                                          label: Text(
                                            _selectedTime.format(context),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(height: height15 * 2),
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: height15,
                                    left: height20 / 2,
                                    right: height20 / 2),
                                child: SizedBox(
                                  height: 43,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      openCheckout();
                                    },
                                    child: const Text(
                                      "Book Appointment",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
    );
  }
}
