import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/providers/auth_provider.dart';
import 'package:kodatel/screen/create_profile.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.phone}) : super(key: key);
  final String phone;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode = "";
  String code = "123456";

  final repassword = TextEditingController();
  final password = TextEditingController();
  final key = GlobalKey<FormState>();

  bool obsecurePass = true;
  bool obsecureRe = true;

  Widget otp() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: backgroundColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: true,
      pinAnimationType: PinAnimationType.fade,
      onCompleted: (pin) {
        setState(() {
          code = pin;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SizedBox(
          height: height(context),
          width: width(context),
          child: Form(
            key: key,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding * 2, vertical: padding),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Verify ${widget.phone}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: padding * 5,
                      ),
                      otp(),
                      const SizedBox(
                        height: padding * 2,
                      ),
                      passwordTextForm(),
                      const SizedBox(
                        height: padding * 2,
                      ),
                      rePasswordTextForm(),
                      const SizedBox(
                        height: padding * 2,
                      ),
                      InkWell(
                          onTap: () async {
                            log(code);
                            if (key.currentState!.validate() &&
                                password.text.trim() ==
                                    repassword.text.trim()) {
                              try {
                                bool value = await Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .handleSignIn(
                                        _verificationCode, code, widget.phone);
                                log(value.toString());
                                if (value == true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateProfile(
                                              phone: widget.phone,
                                              password: repassword.text.trim(),
                                            )),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Number already assigned");
                                }
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                Fluttertoast.showToast(msg: "Invalid OTP");
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .setIsloading(false);
                                log(e.toString());
                              }
                            } else {}
                          },
                          child: Provider.of<AuthProvider>(context).isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const CustomButton(
                                  height: 50, width: 80, text: "Verify"))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget passwordTextForm() {
    return TextFormField(
        obscureText: obsecurePass,
        validator: (value) {
          if (value!.isEmpty) {
            return "Can't be empty";
          }
          return null;
        },
        controller: password,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          helperText: "Password can't be empty",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                width: 2,
                color: backgroundColor,
              )),
          prefixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obsecurePass = !obsecurePass;
                });
              },
              icon: obsecurePass
                  ? const Icon(
                      Icons.visibility,
                      color: backgroundColor,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: backgroundColor,
                    )),
        ));
  }

  Widget rePasswordTextForm() {
    return TextFormField(
        obscureText: obsecureRe,
        validator: (value) {
          if (value!.isEmpty) {
            return "Cant't be empty";
          }
          return null;
        },
        controller: repassword,
        decoration: InputDecoration(
            labelText: "Rematch",
            hintText: "Enter your password",
            helperText: "Password can't be empty",
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(padding)),
                borderSide: BorderSide(
                  width: 2,
                  color: backgroundColor,
                )),
            prefixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecureRe = !obsecureRe;
                  });
                },
                icon: obsecureRe
                    ? const Icon(
                        Icons.visibility,
                        color: backgroundColor,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: backgroundColor,
                      ))));
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
            } else {
              Fluttertoast.showToast(msg: 'Retry');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.message.toString());
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
