import 'package:banter/constants.dart';
import 'package:banter/helper/show_Snackbar.dart';
import 'package:banter/screens/chat_screen.dart';
import 'package:banter/widgets/custom_button.dart';
import 'package:banter/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool _isObscured = true;
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                CustomFormTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  text: 'Email',
                  hint: 'Enter your Email',
                  obscureText: false,
                  isSignup: true,
                ),
                const SizedBox(height: 20),
                CustomFormTextField(
                  onChanged: (value) {
                    password = value;
                  },
                  text: 'Password',
                  hint: 'Enter your Password',
                  obscureText: _isObscured,
                  isSignup: true,
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    text: 'Sign Up',
                    onTAp: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await SignUpNewUser();

                          // Save login status
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);

                          // Show success SnackBar only if no exception is caught
                          ShowSnackBar(
                              context,
                              'Account Created Successfully.',
                              Colors.greenAccent,
                              Icons.check);
                          Navigator.pushNamed(context, ChatScreen.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ShowSnackBar(
                                context,
                                'The password provided is too weak.',
                                Colors.redAccent,
                                Icons.error);
                          } else if (e.code == 'email-already-in-use') {
                            ShowSnackBar(context, 'The account already exists.',
                                Colors.blueAccent, Icons.email);
                          }
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have An Account?',
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
        ),
      ),
    );
  }

  Future<void> SignUpNewUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}