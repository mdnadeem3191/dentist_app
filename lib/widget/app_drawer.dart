import 'package:dentist_app/screens/home_screen.dart';

import 'package:dentist_app/screens/settings.dart';
import 'package:dentist_app/screens/your_appointment.dart';
import 'package:dentist_app/widget/reuse_tile.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../screens/firebase/auth/root_screen.dart';
import '../screens/profile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;

    double height20 = MediaQuery.of(context).size.height / 42.62;

    return Drawer(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              color: Colors.teal,
              height: height50 * 4,
              child: Stack(
                children: [
                  Positioned(
                    left: height20 / 2,
                    bottom: height20,
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL ??
                              "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: height20 / 2,
          ),
          ReUseTile(
              title: "Dashboard",
              iconData: Icons.home,
              onPresssed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ));
              }),
          ReUseTile(
              title: "Profile",
              iconData: Icons.person,
              onPresssed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const Profile();
                  },
                ));
              }),
          ReUseTile(
              title: "Your Appointment",
              iconData: Icons.calendar_month_outlined,
              onPresssed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const YourAppointment();
                  },
                ));
              }),
          ReUseTile(
              title: "Settings",
              iconData: Icons.settings,
              onPresssed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const Settings();
                  },
                ));
              }),
          // ReUseTile(
          //     title: "Privacy Policy",
          //     iconData: Icons.privacy_tip,
          //     onPresssed: () {}),
          // ReUseTile(
          //     title: "Share with friends",
          //     iconData: Icons.share,
          //     onPresssed: () {}),
          ReUseTile(
              title: "Log out",
              iconData: Icons.logout,
              onPresssed: () async {
                await FirebaseAuth.instance.signOut();
                Future.delayed(Duration.zero, () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return RootScreen();
                    },
                  ));
                });
              }),
        ],
      ),
    );
  }
}
