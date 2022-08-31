import 'package:dentist_app/screens/firebase/auth/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;

    double height20 = MediaQuery.of(context).size.height / 42.62;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5abbe5),
      ),
      backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Do you want to delete your account permanent?",
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              )),
                          SizedBox(
                            width: height50 / 2,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.currentUser!
                                    .reload();
                                await FirebaseAuth.instance.currentUser!
                                    .delete();
                                Future.delayed(Duration.zero, () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return RootScreen();
                                    },
                                  ));
                                });
                              },
                              child: const Text(
                                "Confirm",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: height20 / 4, vertical: height20 / 2),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delete Account Permanent",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: height20,
                    ),
                    const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 196, 29, 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
