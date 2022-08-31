import 'package:dentist_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FailedScreen extends StatelessWidget {
  final String paymentId;

  const FailedScreen(this.paymentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;

    return Scaffold(
        backgroundColor: const Color(0xff9edcf0),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 25,
                  color: Colors.black,
                ))
          ],
          elevation: 0,
          title: const Text(
            'Payment Status',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xff9edcf0),
        ),
        body: Card(
          margin: EdgeInsets.symmetric(
              horizontal: height15 * 2, vertical: height50 * 3 + height50 / 2),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white)),
          elevation: 20,
          child: Container(
              height: height50 * 7,
              padding: EdgeInsets.symmetric(
                  horizontal: height48 - height20, vertical: height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.close,
                            size: 60,
                            color: Color.fromARGB(255, 236, 49, 35),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height15,
                      ),
                      const Text(
                        "Payment Failed",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Transaction Id  :  $paymentId',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Amount             :  Rs 500',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height20 / 2,
                  ),
                  Text(
                    'Payment Date  :  ${DateFormat("dd-MM-yyyy").format(DateTime.now())}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height15 * 3,
                  ),
                  const Text(
                    "Please try again",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ));
  }
}
