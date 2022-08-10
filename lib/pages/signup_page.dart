import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

import 'package:kodatel/custom/button.dart';
import 'package:kodatel/screen/otp_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final num = TextEditingController();
  String? initCode = "+92";
  GlobalKey formkey = GlobalKey<FormState>();

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
          padding: const EdgeInsets.all(padding + 30),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/blue_logo.png',
                height: 120,
                width: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: padding + 20,
              ),
              countryCard(),
              const SizedBox(
                height: padding,
              ),
              numTextForm(),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    if (num.text.isNotEmpty) {
                      if (num.text.characters.first == '0') {
                        num.text = num.text.substring(1, num.text.length);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  OTPScreen(phone: initCode! + num.text)));
                    }
                  },
                  child: const CustomButton(
                      height: 50, width: 200, text: "Sign Up"))
            ],
          ),
        ),
      ),
    );
  }

  Widget countryCard() {
    return CountryListPick(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Choose country',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // if you need custom picker use this
      pickerBuilder: (context, CountryCode? countryCode) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: padding, vertical: padding + 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(padding),
                  border: Border.all(color: backgroundColor, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      countryCode!.flagUri!,
                      package: 'country_list_pick',
                    ),
                  ),
                  Expanded(
                      child: Center(
                          child: Text(
                    "${countryCode.name!}(${countryCode.dialCode!})",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ))),
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: backgroundColor,
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        );
      },
      theme: CountryTheme(
        isShowFlag: true,
        isShowCode: true,
        isDownIcon: true,
        showEnglishName: false,
        labelColor: backgroundColor,
      ),
      initialSelection: initCode,
      // or
      // initialSelection: 'US'
      // Whether to allow the widget to set a custom UI overlay
      useUiOverlay: true,
      // Whether the country list should be wrapped in a SafeArea
      useSafeArea: false,
      onChanged: (CountryCode? code) {
        initCode = code!.dialCode;
      },
    );
  }

  Widget numTextForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding - 2),
      child: TextFormField(
        key: formkey,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "Cant't be empty";
          }
          return null;
        },
        controller: num,
        decoration: const InputDecoration(
            labelText: "Phone",
            hintText: "Phone number",
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
      ),
    );
  }
}
