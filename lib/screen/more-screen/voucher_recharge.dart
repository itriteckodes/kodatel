import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';

class VoucherRecharge extends StatefulWidget {
  const VoucherRecharge({Key? key}) : super(key: key);

  @override
  _VoucherRechargeState createState() => _VoucherRechargeState();
}

class _VoucherRechargeState extends State<VoucherRecharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voucher Recharge',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/blue_logo.png',
            height: 120,
            width: 180,
            fit: BoxFit.cover,),
          const SizedBox(
            height: padding + 20,
          ),

          const Center(
              child:  Text(
            "Redeem Voucher",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          ),
          const Padding(
            padding: EdgeInsets.all(60.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Voucher Code',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const VoucherRecharge()));
            },
            child: CustomButton(
                height: 50, width: width(context) * 0.5, text: "Redeem"),
          ),
        ],
      ),
    );
  }
}
