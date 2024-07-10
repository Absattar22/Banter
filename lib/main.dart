
import 'package:banter/screens/sign_in_screen.dart';
import 'package:banter/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Banter());
}

class Banter extends StatelessWidget {
  const Banter({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'SignInScreen' : (context) => const SignInScreen(),
        SignUpScreen.id :(context) => const SignUpScreen(),
      },
      initialRoute: 'SignInScreen',
    );
  }
}
