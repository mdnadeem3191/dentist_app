import 'package:dentist_app/screens/home_screen.dart';
import 'package:dentist_app/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/login_screen.dart';
import '../register/register_screen.dart';

class RootScreen extends StatelessWidget {
  RootScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

//...sign in google function
  Future<User?> signInWithGoogle() async {
    //sign in with google
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    //creating credential for firebase
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

//sign in with credential & making a  user in firebase  and getting user class
    final userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

//checking
    assert(!user!.isAnonymous);

    final User? currentUser = _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    // print(user);
    return user;
  }

  //..
  @override
  Widget build(BuildContext context) {
    double height50 = MediaQuery.of(context).size.height / 17.05;
    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height105 = MediaQuery.of(context).size.height / 8.11;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xff5abbe5),
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Positioned(
                top: height50 * 3,
                left: 0,
                right: 0,
                child: Image.asset(
                  "images/1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: height50,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: height15),
                  child: Column(
                    children: [
                      CustomButton(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ));
                          },
                          buttonWidth: double.infinity,
                          buttonheight: height48,
                          color: const Color.fromARGB(255, 3, 3, 113),
                          elevation: 5,
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          )),
                      SizedBox(
                        height: height15,
                      ),
                      CustomButton(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const RegisterPage();
                              },
                            ));
                          },
                          buttonWidth: double.infinity,
                          buttonheight: height48,
                          color: Colors.white,
                          elevation: 0,
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 3, 3, 113),
                            ),
                          )),
                      SizedBox(
                        height: height15,
                      ),
                      SignInButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          Buttons.GoogleDark,
                          padding: EdgeInsets.symmetric(
                              horizontal: height105,
                              vertical: height15 / 3.75), onPressed: () {
                        signInWithGoogle();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                      }),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
