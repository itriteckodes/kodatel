import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:http/http.dart' as http;


class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final name = TextEditingController();
  String dropdownValue = '5';
   int step = 0;

   Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('http://attn.tritec.store/api/create/intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'a': 'a',
        'price' : dropdownValue
      }),
    );
    final body = json.decode(response.body);

    // if (body['error'] != null) {
    //   throw Exception(body['error']);
    // }
    print(body);
    return body['intent'];
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await _createTestPaymentSheet();

      // create some billingdetails
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // Customer params
          customerId: data['customer'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          // Extra params
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          billingDetails: billingDetails,
          testEnv: true,
          merchantCountryCode: 'DE',
        ),
      );
      setState(() {
        step = 1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> confirmPayment() async {
    print("Asdfasdfsdfasfd");
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        step = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment succesfully completed'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: ${e}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: [
            Image.asset(
              "assets/visa.png",
              fit: BoxFit.fill,
              width: 40,
            ),
            const SizedBox(
              width: padding,
            ),
            const Text("Pay with Card"),
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
            InkWell(
              onTap: ()  async{
             await initPaymentSheet();
                        await confirmPayment();
              },
              child: CustomButton(
                  height: 40, width: width(context) * 0.5, text: "Proceed"),
            )
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
