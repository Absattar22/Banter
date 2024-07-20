
import 'package:banter/constants.dart';
import 'package:banter/helper/show_Snackbar.dart';
import 'package:banter/screens/chat_screen.dart';
import 'package:banter/screens/sign_up_screen.dart';
import 'package:banter/widgets/custom_button.dart';
import 'package:banter/widgets/custom_form_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String id = 'signInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;

  String? password;

  bool isLoading = false;
  


  GlobalKey<FormState> formKey = GlobalKey();

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
                  isSignup: false,
                ),
                const SizedBox(height: 20),
                CustomFormTextField(
                  onChanged: (value) {
                    password = value;
                  },
                  text: 'Password',
                  hint: 'Enter your Password',
                  obscureText: true,
                  isSignup: false,
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    text: 'Sign In',
                    onTAp: () async {
                      if (formKey.currentState!.validate()) {
                        setState(
                          () {
                            isLoading = true;
                          },
                        );
                        try {
                          final credential = await SignInUser();

                          if (credential != null) {
                            ShowSnackBar(context, 'You Sign In Successful.',
                                Colors.greenAccent, Icons.check);
                            Navigator.pushNamed(context, ChatScreen.id);
                          } else {
                            ShowSnackBar(context, 'You Sign In Failed.',
                                Colors.red, Icons.error);
                          }
                        } on FirebaseAuthException catch (e) {
                          String message;
                          if (e.code == 'user-not-found') {
                            message = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            message =
                                'Invalid login credentials.'; 
                          } else {
                            message = 'Icorrect Passoword';
                          }
                          ShowSnackBar(
                              context, message, Colors.red, Icons.error);
                        } finally {
                          setState(() {
                            isLoading =
                                false;
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
                      'Don\'t Have An Account ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: const Text(
                        'Sign Up',
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

  Future<UserCredential> SignInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    return userCredential;
  }
}
