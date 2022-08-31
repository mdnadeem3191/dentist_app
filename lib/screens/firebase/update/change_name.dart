import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../profile.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  bool isLoading = false;
  bool isHide = true;

  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: height15, vertical: height50),
                child: Column(
                  children: [
                    TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Feild is required";
                          }
                          return null;
                        }),
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: "First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                    SizedBox(
                      height: height15,
                    ),
                    TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Feild is required";
                          }
                          return null;
                        }),
                        keyboardType: TextInputType.name,
                        controller: lastNameController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                    SizedBox(
                      height: height50,
                    ),
                    CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName(
                                    "${firstNameController.text} ${lastNameController.text}");
                            Future.delayed(Duration.zero, () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Profile(),
                                  ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Name has been changed. ")));
                            });
                          }
                        },
                        buttonWidth: double.infinity,
                        buttonheight: height50,
                        color: Colors.blue,
                        elevation: 5,
                        child: const Text(
                          "Change Name",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
