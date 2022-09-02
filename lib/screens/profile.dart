import 'package:dentist_app/widget/app_drawer.dart';
import 'package:dentist_app/widget/custom_button.dart';
import 'package:dentist_app/widget/custom_profile_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firebase/update/change_name.dart';
import 'firebase/update/change_password.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;

    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ProfileReUseTile(
              trailing: CustomButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangeName(),
                        ));
                  },
                  buttonWidth: height50 * 2,
                  buttonheight: height15 * 3,
                  color: Colors.grey.withOpacity(0.5),
                  elevation: 0,
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.black),
                  )),
              title: "Name",
              subTitle:
                  FirebaseAuth.instance.currentUser!.displayName ?? "Add Name"),
          ProfileReUseTile(
              trailing: SizedBox(
                  height: height50 - height20 / 2,
                  child: Image.asset(
                    "images/email.png",
                    fit: BoxFit.cover,
                  )),
              title: "Email",
              subTitle: FirebaseAuth.instance.currentUser!.email!),
          ProfileReUseTile(
              trailing: CustomButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ));
                  },
                  buttonWidth: height50 * 2,
                  buttonheight: height15 * 3,
                  color: Colors.grey.withOpacity(0.5),
                  elevation: 0,
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.black),
                  )),
              title: "Password",
              subTitle: "*******"),
        ],
      ),
    );
  }
}
