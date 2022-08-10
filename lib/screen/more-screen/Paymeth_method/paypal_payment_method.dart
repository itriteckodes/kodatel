import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';

class PayPalMethod extends StatefulWidget {
  const PayPalMethod({Key? key}) : super(key: key);

  @override
  _PayPalMethodState createState() => _PayPalMethodState();
}

class _PayPalMethodState extends State<PayPalMethod> {
  final name = TextEditingController();
  String dropdownValue = '5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: [
            Image.asset(
              "assets/paypal.jpeg",
              fit: BoxFit.fill,
              width: 40,
            ),
            const SizedBox(
              width: padding,
            ),
            const Text("Pay with Paypal"),
          ],
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: foregroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 170),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(children: [
            const SizedBox(
              height: padding + 10,
            ),
            statusButton(),
            const SizedBox(
              height: padding + 10,
            ),
            usernameTextForm(),
            const SizedBox(
              height: padding + 10,
            ),
            InkWell(
              onTap: () {},
              child: CustomButton(
                  height: 40, width: width(context) * 0.5, text: "Proceed"),
            ),


          ]),
        ),
      ),
    );
  }

  Widget statusButton() {
    return Container(
        height: 55,
        width: width(context),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(padding)),
            border: Border.all(width: 2, color: backgroundColor)),
        child: ListTile(
            leading: const Icon(
              Icons.attach_money,
              size: 20,
              color: backgroundColor,
            ),
            title: DropdownButton<String>(
              value: dropdownValue,
              underline: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(padding)),
                    border: Border.all(width: 1, color: foregroundColor)),
              ),
              hint: const Text("Select Amount"),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: backgroundColor,
              ),
              elevation: 16,
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold),
              onChanged: (String? newValue) {
                setState(() {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                });
              },
              items: <String>[
                "5",
                '10',
                '15',
                '20',
                '25',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                      width: width(context) * 0.45, child: Text(value)),
                );
              }).toList(),
            )));
  }
}

Widget usernameTextForm() {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter amount";
      }
      return null;
    },
    decoration: const InputDecoration(
        labelText: "Email*",
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
  );
}
