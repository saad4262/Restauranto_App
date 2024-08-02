import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login.dart';
import 'main.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home page after a 3-second delay
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.redAccent,
              Colors.orangeAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Restaurant Logo
            Image.asset(
              'assets/images/pizza.png', // Replace with your logo asset path
              height: 120.0,
            ),
            SizedBox(height: 20.0),
            // Restaurant Name
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Restauranto',
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Schyler",
                    color: Colors.white70,


                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 500),
            ),
            SizedBox(height: 10.0),
            // Tagline or Description
            Text(
              'Savor the Taste of Excellence',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

