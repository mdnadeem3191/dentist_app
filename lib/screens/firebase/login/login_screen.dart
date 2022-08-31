import 'package:dentist_app/screens/firebase/email_verify/send_verification.dart';
import 'package:dentist_app/screens/firebase/email_verify/signup_verify_email.dart';
import 'package:dentist_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import '../../../widget/custom_button.dart';
import '../register/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHide = true;

  bool isLoading = false;
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height105 = MediaQuery.of(context).size.height / 8.11;

    final height98 = height / 8.78;

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: height15),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: height98),
                      child: const Text(
                        "Login",
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
                            borderSide: const BorderSide(color: Colors.black)),
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
                          return "Feild is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isHide,
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
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            setState(() {
                              isHide = !isHide;
                            });
                            await FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            Future.delayed(Duration.zero, () async {
                              await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirebaseAuth
                                            .instance.currentUser!.emailVerified
                                        ? const HomeScreen()
                                        : SignUpVerifyEmail(
                                            emailController:
                                                emailController.text),
                                  ));
                            });
                          } on FirebaseException catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: height15 + height15 / 3,
                          ),
                          const Icon(
                            fluent.FluentIcons.signin,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height15 / 3,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      StatefulBuilder(
                        builder: (context, setState) => CustomButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SendVerification(),
                                  ));
                            },
                            buttonWidth: height105,
                            buttonheight: (height15 * 2) / 3,
                            color: Colors.white,
                            elevation: 0,
                            child: const Text(
                              "Forget Password",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )),
                      ),
                      CustomButton(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPage();
                              },
                            ));
                          },
                          buttonWidth: height105,
                          buttonheight: (height15 * 2) / 3,
                          color: Colors.white,
                          elevation: 0,
                          child: const Text(
                            "Create Account",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          )),
                    ]),
                  ],
                ),
              ),
            ),
    );
  }
}
