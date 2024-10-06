import 'package:donation/components/login_page.dart';
import 'package:donation/components/otpscreen.dart';
import 'package:donation/components/screens/detailsScreen.dart';
import 'package:donation/components/screens/splashscreen.dart';
import 'package:donation/components/common/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'components/screens/exportsScreens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Donation());
}

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        LoginPage.id: (context) => LoginPage(),
        OtpScreen.id: (context) => OtpScreen(verificationId: ''),
        basicDetails.id: (context) => basicDetails(),
        HomePage.id: (context) => HomePage(),
        Education.id: (context) => Education(),
        SeniorPage.id: (context) => SeniorPage(),
        Article.id: (context) => Article(),
        Ehelp.id: (context) => Ehelp(),
        Clothes.id: (context) => Clothes(),
        Health.id: (context) => Health(),
        OnboardingScreen.id: (context) => OnboardingScreen(), // Add onboarding screen route
      },
      theme: ThemeData(
        primaryColor: Color(0xFF5B86E5),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromARGB(255, 108, 173, 230)),
      ),
    );
  }
}
