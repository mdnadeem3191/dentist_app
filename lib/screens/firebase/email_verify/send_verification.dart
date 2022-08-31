import 'package:dentist_app/screens/firebase/auth/root_screen.dart';
import 'package:dentist_app/screens/firebase/email_verify/email_verify.dart';
import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendVerification extends StatelessWidget {
  SendVerification({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height15 = MediaQuery.of(context).size.height / 56.838;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff5abbe5),
        centerTitle: true,
        title: const Text(
          "Email Verified",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: height15, vertical: height50),
          child: Column(
            children: [
              const Text(
                "Reset Link will be sent to your email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: (height15 * 2) + (height15 / 3) * 2,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Feild is required";
                  }
                  return null;
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: height50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RootScreen(),
                            ));
                      },
                      buttonWidth: height50 * 3 - height15 * 2,
                      buttonheight: height50,
                      color: Colors.white,
                      elevation: 0,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )),
                  SizedBox(
                    width: height50 / 2,
                  ),
                  CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          try {
                            FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailVerified(
                                      emailController: emailController.text),
                                ));
                          } on FirebaseAuthException catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(error.message.toString())));
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          }
                        }
                      },
                      buttonWidth: height50 * 3 - height15 * 2,
                      buttonheight: height50,
                      color: Colors.blue,
                      elevation: 5,
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
