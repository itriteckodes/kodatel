import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/pages/login_page.dart';
import 'package:kodatel/pages/signup_page.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: width(context),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("MeriCall"),
            const SizedBox(
              height: padding + 30,
            ),
            const Text(
              "New User",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()));
              },
              child: CustomButton(
                  height: 50, width: width(context) * 0.5, text: "Sign Up"),
            ),
            const SizedBox(
              height: padding,
            ),
            const Text(
              "Registration Required",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: padding,
            ),
            const CircleAvatar(
                radius: 22,
                child: Text(
                  "or",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: padding,
            ),
            const Text(
              "Existing Customer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: padding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: CustomButton(
                  height: 50, width: width(context) * 0.5, text: "Login"),
            ),
            const SizedBox(
              height: padding,
            ),
            const Text(
              "Registration Required",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
