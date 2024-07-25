import 'package:banter/constants.dart';
import 'package:banter/helper/show_Snackbar.dart';
import 'package:banter/screens/chat_screen.dart';
import 'package:banter/screens/sign_up_screen.dart';
import 'package:banter/widgets/custom_button.dart';
import 'package:banter/widgets/custom_form_text_field.dart';
import 'package:banter/widgets/other_signin_option_buuton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isObscured = true;

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
                  obscureText: _isObscured,
                  isSignup: false,
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
                          final credential = await SignInUser();

                          if (credential != null) {
                            ShowSnackBar(context, 'You signed in successfully.',
                                Colors.greenAccent, Icons.check);

                            // Save login status
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);

                            Navigator.pushNamed(context, ChatScreen.id);
                          } else {
                            ShowSnackBar(context, 'Sign in failed.', Colors.red,
                                Icons.error);
                          }
                        } on FirebaseAuthException catch (e) {
                          String message;
                          if (e.code == 'user-not-found') {
                            message = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            message = 'Invalid login credentials.';
                          } else {
                            message = 'An error occurred. Please try again.';
                          }
                          ShowSnackBar(
                              context, message, Colors.red, Icons.error);
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
                      'Don\'t have an account?',
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
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 20),
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 10),
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                OtherSigninOptionButton(
                  text: 'Sign in with Google',
                  img: 'assets/images/google.png',
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await signInWithGoogle();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ChatScreen.id, (route) => false);
                      ShowSnackBar(context, 'You signed in successfully.',
                          Colors.greenAccent, Icons.check);
                    } catch (e) {
                      print('------------------------ $e');
                      ShowSnackBar(
                          context, 'Sign in failed.', Colors.red, Icons.error);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
