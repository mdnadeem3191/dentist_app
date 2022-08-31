import 'package:dentist_app/screens/firebase/auth/root_screen.dart';
import 'package:dentist_app/screens/home_screen.dart';
import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpVerifyEmail extends StatefulWidget {
  final String emailController;
  const SignUpVerifyEmail({Key? key, required this.emailController})
      : super(key: key);

  @override
  State<SignUpVerifyEmail> createState() => _SignUpVerifyEmailState();
}

class _SignUpVerifyEmailState extends State<SignUpVerifyEmail> {
  checkEmailVerify() async {
    await FirebaseAuth.instance.currentUser!.reload();
    final isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified) {
      return Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      });
    } else {
      return checkEmailVerify();
    }
  }

  @override
  void initState() {
    setState(() {
      Future.delayed(const Duration(seconds: 1), () {
        checkEmailVerify();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;

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
                      await FirebaseAuth.instance.currentUser!.reload();
                      await FirebaseAuth.instance.currentUser!.delete();
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RootScreen(),
                            ));
                      });
                    },
                    buttonWidth: height50 * 3 - height15 * 2,
                    buttonheight: height50,
                    color: Colors.blue,
                    elevation: 5,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  width: height20,
                ),
                CustomButton(
                    onTap: () async {
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                    },
                    buttonWidth: height50 * 3 - height15 * 2,
                    buttonheight: height50,
                    color: Colors.blue,
                    elevation: 5,
                    child: const Text(
                      "Send Again",
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
