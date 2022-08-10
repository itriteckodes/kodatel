import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'package:kodatel/custom/button.dart';

import '../../../constant.dart';

class ConfirSubcrice extends StatefulWidget {
  const ConfirSubcrice(
      {Key? key, required this.title, required this.price, required this.validity, required this.mints})
      : super(key: key);
  final String title;
  final String price;
  final String validity;
  final String mints;

  @override
  State<ConfirSubcrice> createState() => _ConfirSubcriceState();
}

class _ConfirSubcriceState extends State<ConfirSubcrice> {
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
        'price' : widget.price
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
          children: const [
            Icon(
              Icons.subscriptions,
              size: 30,
            ),
            SizedBox(
              width: padding,
            ),
            Text("Subcribe Packages"),
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
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Title: ${widget.title}',
            style: const TextStyle(fontSize: fontSize, fontWeight: bold),
          ),
          const SizedBox(
            height: padding,
          ),
          Text('Cost: ${widget.price}'),
          const SizedBox(
            height: padding,
          ),
          Text('Validity: ${widget.validity}'),
          const SizedBox(
            height: padding,
          ),
          Text('Max Minutes: ${widget.mints}'),
          const SizedBox(
            height: padding * 5,
          ),
          InkWell(
              onTap: () {
                showDialog(context: context, builder: (dialContext) => dialog(widget.price, dialContext));
              },
              child: CustomButton(height: 50, width: 180, text: 'Subcribe For \$${widget.price}'))
        ],
      )),
    );
  }

  Widget dialog(String price, BuildContext dialContext) {
    return Dialog(
      child: SizedBox(
        height: 160,
        child: Column(children: [
          const SizedBox(
            height: padding,
          ),
          const Center(
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.amber, fontWeight: bold),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 2,
          ),
          const SizedBox(
            height: padding * 2,
          ),
          Text(
            'Subcribe For \$$price',
            style: const TextStyle(fontSize: fontSize * 1.2),
          ),
          const SizedBox(
            height: padding * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 100,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(dialContext);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: bold),
                      ))),
              const SizedBox(
                width: padding * 2,
              ),
              Container(
                  width: 100,
                  decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                      onPressed: () async {
                        Navigator.pop(dialContext);

                        await initPaymentSheet();
                        await confirmPayment();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: bold),
                      ))),
            ],
          )
        ]),
      ),
    );
  }
}
