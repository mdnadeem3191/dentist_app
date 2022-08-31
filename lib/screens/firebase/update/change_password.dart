import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../profile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isHide = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height15 = MediaQuery.of(context).size.height / 56.838;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dentist App"),
        backgroundColor: Colors.teal,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: height15, vertical: height50),
          child: Column(
            children: [
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
                      passwordController.text.contains(RegExp('[0-9]'))) {
                    return "Atleast one number";
                  } else if (value.isNotEmpty !=
                      passwordController.text
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return "Atleast one special character like @,\$,#...";
                  } else if (passwordController.text !=
                      passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
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
                height: height15,
              ),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is required";
                    } else if (value.length < 6) {
                      return "Password should be atleast 6 character";
                    } else if (value.isNotEmpty !=
                        newPasswordController.text
                            .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                      return "Atleast one Lower Case";
                    } else if (value.isNotEmpty !=
                        newPasswordController.text
                            .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                      return "Atleast one Upper Case";
                    } else if (value.isNotEmpty !=
                        newPasswordController.text.contains(RegExp('[0-9]'))) {
                      return "Atleast one number";
                    } else if (value.isNotEmpty !=
                        newPasswordController.text
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return "Atleast one special character like @,\$,#...";
                    } else if (newPasswordController.text !=
                        confirmNewPasswordController.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
                    hintText: "New Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
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
                      confirmNewPasswordController.text
                          .contains(RegExp("(?:[^a-z]*[a-z]){1}"))) {
                    return "Atleast one Lower Case";
                  } else if (value.isNotEmpty !=
                      confirmNewPasswordController.text
                          .contains(RegExp("(?:[^A-Z]*[A-Z]){1}"))) {
                    return "Atleast one Upper Case";
                  } else if (value.isNotEmpty !=
                      confirmNewPasswordController.text
                          .contains(RegExp('[0-9]'))) {
                    return "Atleast one number";
                  } else if (value.isNotEmpty !=
                      confirmNewPasswordController.text
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return "Atleast one special character like @,\$,#...";
                  } else if (confirmNewPasswordController.text !=
                      passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                controller: confirmNewPasswordController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
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
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(newPasswordController.text);
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Password has been changed. ")));
                        });
                      } on FirebaseAuthException catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.message.toString())));
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      }
                    }
                  },
                  buttonWidth: double.infinity,
                  buttonheight: height50,
                  color: Colors.blue,
                  elevation: 5,
                  child: const Text(
                    "Change Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
