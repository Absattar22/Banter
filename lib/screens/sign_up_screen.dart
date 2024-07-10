
import 'package:banter/constants.dart';
import 'package:banter/widgets/custom_button.dart';
import 'package:banter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatelessWidget {
    const SignUpScreen({super.key});
    static  String id = 'signUpScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/icon.png',
                width: 250,
                height: 250,
              ),
            ),
            const CustomTextField(
              text: 'Email',
              hint: 'Enter your Email',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
                text: 'Password',
                hint: 'Enter your Password',
                obscureText: true),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  // Add your logic here
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already Have An Account ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
