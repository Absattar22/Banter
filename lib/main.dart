
import 'package:banter/screens/sign_in_screen.dart';
import 'package:banter/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Banter());
}

class Banter extends StatelessWidget {
  const Banter({super.key});

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
