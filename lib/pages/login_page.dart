import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/pages/home_page.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final password = TextEditingController();

  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: padding + 10, vertical: 30),
          child: Column(
            children: [
              Image.asset(
                'assets/blue_logo.png',
                height: 120,
                width: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: padding + 20,
              ),
              usernameTextForm(),
              const SizedBox(
                height: padding + 10,
              ),
              passwordTextForm(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () async {
                    if (username.text.isNotEmpty && password.text.isNotEmpty) {
                      bool found = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .logIn(username.text.trim(),
                              encryptText(password.text.trim()));
                      if (found) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .prefs
                            .setBool('login', true);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Wrong username or password");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Fill phone & password");
                    }
                  },
                  child: Provider.of<AuthProvider>(context).isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const CustomButton(
                          height: 50, width: 200, text: "Login")),
            ],
          ),
        ),
      ),
    );
  }

  Widget usernameTextForm() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Cant't be empty";
        }
        return null;
      },
      controller: username,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          labelText: "Phone",
          hintText: "Enter your Phone",
          helperText: "Phone can't be empty",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                width: 2,
                color: backgroundColor,
              )),
          prefixIcon: Icon(
            Icons.phone_android_rounded,
            color: backgroundColor,
          )),
    );
  }

  Widget passwordTextForm() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Cant't be empty";
        }
        return null;
      },
      controller: password,
      obscureText: true,
      decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          helperText: "Password can't be empty",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                width: 2,
                color: backgroundColor,
              )),
          prefixIcon: Icon(
            Icons.password,
            color: backgroundColor,
          )),
    );
  }
}
