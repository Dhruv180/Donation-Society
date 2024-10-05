import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/components/otpscreen.dart';
import 'package:donation/components/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:donation/components/screens/detailsScreen.dart';


class LoginPage extends StatefulWidget {
  static const String id = 'Login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController phoneController = TextEditingController();
  String verificationID = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink[600],
          borderRadius: BorderRadius.circular(54),
        ),
        height: 500,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Spread Kindness :)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefix: Text("+91",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getOtp,
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 155, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getOtp() async {
    setState(() {
      errorMessage = ""; // Clear previous error messages
    });

    // Basic validation
    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
      setState(() {
        errorMessage = "Please enter a valid phone number.";
      });
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (phoneAuthCredential) async {
          // If verification is completed automatically
          await _auth.signInWithCredential(phoneAuthCredential);
          // Check Firestore for user details after successful auto-verification
          await checkUserDetails();
        },
        verificationFailed: (verificationFailed) {
          setState(() {
            errorMessage = "Verification failed. ${verificationFailed.message}";
          });
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            this.verificationID = verificationID;
          });
          // Navigate to OTP screen after OTP is sent
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationID),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationID) {
          // Handle timeout if necessary
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
      print("Error during OTP request: $e");
    }
  }

  Future<void> checkUserDetails() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDetails = await _firestore.collection('users').doc(user.uid).get();

      if (userDetails.exists) {
        // User details exist; navigate to HomePage
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        // User details do not exist; navigate to basicDetails
        Navigator.pushReplacementNamed(context, basicDetails.id);
      }
    }
  }
}
