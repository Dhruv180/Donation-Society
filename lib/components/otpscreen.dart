
import 'package:donation/components/screens/detailsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const String id = 'otp_screen'; // Properly defined ID
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.pink[600], borderRadius: BorderRadius.circular(54)),
        height: 500,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    labelStyle: TextStyle(fontSize: 19),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  AuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otpController.text);
                  signin(phoneAuthCredential);
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.yellow[700],
                    padding:
                        EdgeInsets.symmetric(horizontal: 152, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                    ))),
            SizedBox(height: 19),
            Text(
              "Haven't received OTP?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  // Implement resend OTP functionality
                },
                child: Text(
                  "Resend",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  void signin(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => basicDetails()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Some Error Occurred. Try Again Later')));
    }
  }
}
