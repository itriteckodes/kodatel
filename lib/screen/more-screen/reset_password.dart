import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/pages/login_page.dart';
import 'package:kodatel/providers/auth_provider.dart';
import 'package:kodatel/screen/more_settings.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: padding + 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                  child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/blue_logo.png'),
              )),
            ),
            const SizedBox(
              height: padding * 2,
            ),
            usernameTextForm(),
            const SizedBox(
              height: padding + 5,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  if (pass.text.isNotEmpty) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .resetPassword(encryptText(pass.text.trim()));
                    Fluttertoast.showToast(msg: 'Password Changed');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false);
                  }
                },
                child:
                    const CustomButton(height: 50, width: 200, text: "Done")),
          ],
        ),
      ),
    );
  }

  Widget usernameTextForm() {
    return TextFormField(
      obscureText: true,
      controller: pass,
      validator: (value) {
        if (value!.isEmpty) {
          return "Cant't be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Enter new password",
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding * 2)),
              borderSide: BorderSide(
                width: 1,
                color: backgroundColor,
              )),
          prefixIcon: Icon(
            Icons.remove_red_eye_outlined,
            color: backgroundColor,
          )),
    );
  }
}
