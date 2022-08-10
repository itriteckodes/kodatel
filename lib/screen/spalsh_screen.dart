import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/pages/home_page.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:kodatel/screen/landing_screen.dart';
import 'package:provider/provider.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  Widget page() {
    bool? login = Provider.of<AuthProvider>(context).prefs.getBool('login');
    if (login != null && login) {
      return const HomePage();
    } else {
      return const LandingScreen();
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => page()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Image.asset(
            'assets/blue_logo.png',
            height: 120,
            width: 180,
            fit: BoxFit.cover,
          ),
        ));
  }
}
