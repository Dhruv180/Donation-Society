import 'package:donation/components/common/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../reusable_card.dart';
import 'Education_payment.dart';
import 'blood.dart';
import './food.dart';
import './clothes.dart';
import 'Article_payment.dart';
import 'Seniorpage_Payment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "\n In which Category You\nWant To Donate?\n",
          textAlign: TextAlign.center,
          style: GoogleFonts.acme(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.9),
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.5),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _showLogoutDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ReusableCard(
                      time: 1,
                      image: 'images/clothes1.jpg',
                      nextChild: Clothes(),
                    ),
                    ReusableCard(
                      time: 2,
                      image: 'images/blood.jpg',
                      nextChild: Health(),
                    ),
                    ReusableCard(
                      time: 3,
                      image: 'images/food.jpg',
                      nextChild: Ehelp(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    ReusableCard(
                      time: 4,
                      image: 'images/edu.jpg',
                      nextChild: Education(),
                    ),
                    ReusableCard(
                      time: 5,
                      image: 'images/wash.jpg',
                      nextChild: Article(),
                    ),
                    ReusableCard(
                      time: 6,
                      image: 'images/senior.jpg',
                      nextChild: SeniorPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Call logout method
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Navigator.pushReplacementNamed(context, OnboardingScreen.id); // Navigate to onboarding screen
    } catch (e) {
      print("Logout error: $e"); // Handle any errors if necessary
    }
  }
}
