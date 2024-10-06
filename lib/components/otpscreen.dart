import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:donation/components/screens/home_page.dart'; // Adjust based on your project structure

class OtpScreen extends StatefulWidget {
  static const String id = 'otp_screen'; // Define the route ID

  final String verificationId;

  OtpScreen({required this.verificationId});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.pink[600],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                Text(
                  "Enter OTP",
                  style: TextStyle(
                    color: Colors.pink[600],
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "OTP",
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: screenHeight * 0.02),
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(fontSize: screenWidth * 0.05),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.yellow[700],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextButton(
                  onPressed: () {
                    // Optionally handle resend OTP
                  },
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: Colors.pink[600],
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyOtp() async {
    setState(() {
      errorMessage = ""; // Clear previous error messages
    });

    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      setState(() {
        errorMessage = "Please enter a valid OTP.";
      });
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, HomePage.id); // Navigate to HomePage
    } catch (e) {
      setState(() {
        errorMessage = "Invalid OTP. Please try again.";
      });
    }
  }
}
