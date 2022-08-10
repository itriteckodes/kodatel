import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';

class TransferBalance extends StatefulWidget {
  const TransferBalance({Key? key}) : super(key: key);

  @override
  _TransferBalanceState createState() => _TransferBalanceState();
}

class _TransferBalanceState extends State<TransferBalance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Balance Transfer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: bold,
          ),
        ),
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
            children: <Widget>[
              Image.asset('assets/blue_logo.png',
                height: 120,
                width: 180,
                fit: BoxFit.cover,),
              const SizedBox(
                height: padding + 20,
              ),
              const Text(
                "Transfer Credits to",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter mobile number with +",
                style: TextStyle(fontWeight: FontWeight.w500),
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
                  onTap: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => const CreateProfile()));
                  },
                  child: const CustomButton(
                      height: 50, width: 200, text: "Transfer Credit")),
            ],
          ),
        ),
      ),
    );
  }
}

Widget usernameTextForm() {
  return Padding(
    padding: const EdgeInsets.all(17.0),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Can't be empty";
        }
        return null;
      },
      // controller: username,
      decoration: const InputDecoration(
          labelText: "Mobile Number",
          hintText: "Enter Number",
          helperText: "Number can't be empty",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                width: 2,
                color: backgroundColor,
              )),
          prefixIcon: Icon(
            Icons.person,
            color: backgroundColor,
          )),
    ),
  );
}

Widget passwordTextForm() {
  return Padding(
    padding: const EdgeInsets.all(17.0),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Can't be empty";
        }
        return null;
      },
      // controller: password,
      decoration: const InputDecoration(
          labelText: "Enter Credits",
          hintText: "Enter your Cridets",
          helperText: "Can't be empty",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                width: 2,
                color: backgroundColor,
              )),
          prefixIcon: Icon(
            Icons.credit_card,
            color: backgroundColor,
          )),
    ),
  );
}
