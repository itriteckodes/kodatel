import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/custom_list_tile.dart';
import 'package:kodatel/screen/more-screen/support/contact_support.dart';
import 'package:kodatel/screen/more-screen/support/faqs_page.dart';
import 'package:kodatel/screen/more-screen/support/terms_conditions.dart';
import 'package:kodatel/screen/offer_screen.dart';

class Supportpage extends StatelessWidget {
  const Supportpage({Key? key}) : super(key: key);

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
            Text("Support"),
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Image.asset(
                'assets/blue_logo.png',
                height: 120,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "MeriCall",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ContactSupport()));
            },
            child: const CustomListTile(
              title: 'Contact Support',
              icon: Icons.support,
              tralig: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FAQSPAGE()));
            },
            child: const CustomListTile(
              title: 'FAQ',
              icon: Icons.question_answer,
              tralig: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TermsCondition()));
            },
            child: const CustomListTile(
              title: 'Terms & Conditions',
              icon: Icons.control_point,
              tralig: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OfferScreen(
                        isBeforeLogin: false,
                      )));
            },
            child: const CustomListTile(
              title: 'Quick Tour',
              icon: Icons.support,
              tralig: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}
