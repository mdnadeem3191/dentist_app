import 'package:dentist_app/screens/firebase/auth/root_screen.dart';
import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerified extends StatefulWidget {
  final String emailController;
  const EmailVerified({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<EmailVerified> createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {
  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height15 = MediaQuery.of(context).size.height / 56.838;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: height50 / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "A verification link has been sent to ${widget.emailController}.Please check your mail or spam",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    onTap: () async {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: widget.emailController);
                    },
                    buttonWidth: height50 * 3 - (height15 / 3) * 2,
                    buttonheight: height50,
                    color: Colors.blue,
                    elevation: 5,
                    child: const Text(
                      "Resend Again",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  width: height15 + height15 - (height15 / 3) * 2,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RootScreen(),
                          ));
                    },
                    buttonWidth: height50 * 3 - (height15 / 3) * 2,
                    buttonheight: height50,
                    color: Colors.blue,
                    elevation: 5,
                    child: const Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
