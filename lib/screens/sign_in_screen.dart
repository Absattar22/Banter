import 'package:banter/constants.dart';
import 'package:banter/helper/show_Snackbar.dart';
import 'package:banter/screens/chat_screen.dart';
import 'package:banter/screens/sign_up_screen.dart';
import 'package:banter/widgets/custom_button.dart';
import 'package:banter/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});
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
                CustomTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  text: 'Email',
                  hint: 'Enter your Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  onChanged: (value) {
                    password = value;
                  },
                  text: 'Password',
                  hint: 'Enter your Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    text: 'Sign In',
                    onTAp: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await SignInUser();
                          ShowSnackBar(context, 'You Sign In Successful.',
                              Colors.greenAccent, Icons.check);
                              Navigator.pushNamed(context, ChatScreen.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ShowSnackBar(
                                context,
                                'No user found for that email.',
                                Colors.red,
                                Icons.error);
                          } else if (e.code == 'wrong-password') {
                            ShowSnackBar(context, 'Wrong password ', Colors.red,
                                Icons.password_outlined);
                          }
                        }
                        setState(
                          () {
                            isLoading = false;
                          },
                        );
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

  Future<void> SignInUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
