import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class TransactionHistroy extends StatefulWidget {
  const TransactionHistroy({Key? key}) : super(key: key);

  @override
  _TransactionHistroyState createState() => _TransactionHistroyState();
}

class _TransactionHistroyState extends State<TransactionHistroy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: const [
            Icon(
              Icons.history_edu_rounded,
              size: 30,
            ),
            SizedBox(
              width: padding,
            ),
            Text("Transaction History"),
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

      body: const Center(child: Text("No Transaction Found")),
    );
  }
}
