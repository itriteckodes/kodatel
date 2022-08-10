import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/screen/more-screen/Paymeth_method/ideal_payment_menthod.dart';
import 'package:kodatel/screen/more-screen/Paymeth_method/payment_method_add.dart';
import 'package:kodatel/screen/more-screen/Paymeth_method/paypal_payment_method.dart';

Widget bottomSheet(BuildContext context) {
  return SizedBox(
    height: 200,
    width: width(context),
    child: Column(
      children: [
        Container(
          height: padding * 4,
          width: width(context),
          color: backgroundColor,
          child: const Center(
            child: Text(
              "Select Payment Mode",
              style: TextStyle(
                  fontWeight: bold, fontSize: fontSize, color: foregroundColor),
            ),
          ),
        ),
        const SizedBox(
          height: padding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const PaymentMethod()));
                },
                child:
                    showCardTile(80, width(context) * 0.4, "assets/visa.png")),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const IdealPayment()));
                },
                child:
                    showCardTile(80, width(context) * 0.4, "assets/ideal.png")),
          ],
        ),
        // const SizedBox(
        //   height: padding,
        // ),
        // InkWell(
        //     onTap: () {
        //       Navigator.of(context).push(
        //           MaterialPageRoute(builder: (_) => const PayPalMethod()));
        //     },
        //     child: showCardTile(50, width(context) - 50, "assets/paypal.jpeg")),
      ],
    ),
  );
}

Widget showCardTile(double height, double width, String source) {
  return Container(
    padding: const EdgeInsets.all(padding),
    height: height,
    width: width,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: backgroundColor),
        borderRadius: BorderRadius.circular(padding)),
    child: Center(
        child: Image.asset(
      source,
      fit: BoxFit.fill,
      width: 120,
    )),
  );
}
