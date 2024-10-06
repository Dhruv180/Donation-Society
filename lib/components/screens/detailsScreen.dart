import 'package:donation/components/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class basicDetails extends StatefulWidget {
  static const String id = 'details_screen'; // Add an ID for navigation

  const basicDetails({Key? key}) : super(key: key);

  @override
  _basicDetailsState createState() => _basicDetailsState();
}

class _basicDetailsState extends State<basicDetails> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Optionally, if you want to pre-fill the fields if they exist
    loadExistingUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Enable scrolling
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.pink[600],
                borderRadius: BorderRadius.circular(54),
                boxShadow: [
                  BoxShadow(color: Colors.yellow.shade700, spreadRadius: 8)
                ],
              ),
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Basic Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            buildTextField("Name", nameController, isNameField: true),
            SizedBox(height: 20),
            buildTextField("Email", emailController, isEmailField: true),
            SizedBox(height: 20),
            buildTextField("Contact Number", contactNumberController),
            SizedBox(height: 120),
            ElevatedButton(
              onPressed: () {
                if (validateInputs()) {
                  storeBasicDetails();
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                backgroundColor: Colors.yellow.shade700,
                padding: EdgeInsets.symmetric(horizontal: 152, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isNameField = false, bool isEmailField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(40),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 19),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 5),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
          ),
          keyboardType: label == "Contact Number" ? TextInputType.phone : TextInputType.text,
          inputFormatters: isNameField ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))] : [],
        ),
      ),
    );
  }

  bool validateInputs() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String contactNumber = contactNumberController.text.trim();

    if (name.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      showError("Please enter a valid name (letters only).");
      return false;
    }
    if (email.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      showError("Please enter a valid email.");
      return false;
    }
    if (contactNumber.isEmpty || !RegExp(r'^\d+$').hasMatch(contactNumber) || contactNumber.length != 10) {
      showError("Please enter a valid contact number (10 digits).");
      return false;
    }

    return true;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void storeBasicDetails() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String contactNumber = contactNumberController.text.trim();
    
    // Store details in Firestore
    await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
    }).then((_) {
      // Navigate to HomePage after storing details
      Navigator.pushReplacementNamed(context, HomePage.id); // Ensure you have a route for HomePage
    }).catchError((error) {
      showError("Failed to store details: $error");
    });
  }

  Future<void> loadExistingUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDetails = await _firestore.collection('users').doc(user.uid).get();

      if (userDetails.exists) {
        // Pre-fill the text fields with existing user data
        var data = userDetails.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        contactNumberController.text = data['contactNumber'] ?? '';
      }
    }
  }
}
