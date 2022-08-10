import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({Key? key}) : super(key: key);

  @override
  _ContactSupportState createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: const [
            Icon(
              Icons.support,
              size: 30,
            ),
            SizedBox(
              width: padding,
            ),
            Text("Contact Support"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/blue_logo.png',
              height: 120,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: padding + 20,
          ),
          suppoertext(),
        ],
      ),
    );
  }
}

Widget suppoertext() {
  return Container();
}
