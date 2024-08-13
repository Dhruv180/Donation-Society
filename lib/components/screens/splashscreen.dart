import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:donation/components/screens/home_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay to display the splash screen
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust color as needed
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Main animation (behind the splash animation)
          Lottie.asset(
            'images/Animation.json', // Adjust the path as per your project structure
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            
          ),
          // Splash animation (on top of the main animation)
          Lottie.asset(
            'images/Splash.json', // Adjust the path as per your project structure
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
         
          ),
        ],
      ),
    );
  }
}
