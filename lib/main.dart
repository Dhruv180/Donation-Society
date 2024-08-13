import 'package:donation/components/screens/splashscreen.dart';
import 'package:flutter/material.dart';

import 'components/screens/exportsScreens.dart';

void main() => runApp(Donation());

class Donation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        HomePage.id: (context) => HomePage(),
        Education.id: (context) => Education(),
        SeniorPage.id: (context) => SeniorPage(),
        Article.id: (context) => Article(),
        Ehelp.id: (context) => Ehelp(),
        Clothes.id: (context) => Clothes(),
        Health.id: (context) => Health(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFF5B86E5), 
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromARGB(255, 108, 173, 230)),
      ),
    );
  }
}
