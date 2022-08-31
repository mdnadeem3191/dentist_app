import 'package:dentist_app/screens/firebase/email_verify/signup_verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import '../../../widget/custom_button.dart';
import '../login/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final TextEditingController firstNameController = TextEditingController();
  // final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isHide = true;

  bool isLoading = false;
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;

    final height98 = height / 8.78;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: height15),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: height98),
                        child: const Text(
                          "Create an Account",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),

                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 character";
                          } else if (value.isNotEmpty !=
                              passwordController.text
                                  .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                            return "Atleast one Lower Case";
                          } else if (value.isNotEmpty !=
                              passwordController.text
                                  .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                            return "Atleast one Upper Case";
                          } else if (value.isNotEmpty !=
                              passwordController.text
                                  .contains(RegExp('[0-9]'))) {
                            return "Atleast one number";
                          } else if (value.isNotEmpty !=
                              passwordController.text.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return "Atleast one special character like @,\$,#...";
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 character";
                          } else if (value.isNotEmpty !=
                              confirmPasswordController.text
                                  .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                            return "Atleast one Lower Case";
                          } else if (value.isNotEmpty !=
                              confirmPasswordController.text
                                  .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                            return "Atleast one Upper Case";
                          } else if (value.isNotEmpty !=
                              confirmPasswordController.text
                                  .contains(RegExp('[0-9]'))) {
                            return "Atleast one number";
                          } else if (value.isNotEmpty !=
                              confirmPasswordController.text.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return "Atleast one special character like @,\$,#...";
                          } else if (confirmPasswordController.text !=
                              passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isHide,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isHide = !isHide;
                                });
                              },
                              icon: Icon(
                                isHide
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: Colors.black,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height50,
                      ),
                      CustomButton(
                        elevation: 5,
                        color: const Color(0xFF2196F3),
                        buttonWidth: double.infinity,
                        buttonheight: height48,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isLoading = true;
                              });

                              await FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification();
                              Future.delayed(const Duration(seconds: 0), () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpVerifyEmail(
                                      emailController: emailController.text,
                                    );
                                  },
                                ));
                              });
                            } on FirebaseException catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(error.message.toString())));
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString())));
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: height15 + height15 / 3,
                            ),
                            const Icon(
                              fluent.FluentIcons.people_add,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height15 / 3,
                      ),
                      CustomButton(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ));
                        },
                        buttonWidth: double.infinity,
                        buttonheight: (height15 / 3) * 2,
                        color: Colors.white,
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an Account?",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: (height15 / 3) * 2,
                            ),
                            const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )
                          ],
                        ),
                      ),

                      //
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
