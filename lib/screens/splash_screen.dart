import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/homescreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height * 1;
    // final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: 500.0,
              width: 500.0,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'TOP HEADLINES',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 20.0,
                letterSpacing: .6,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const SpinKitChasingDots(
              color: Colors.blue,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
