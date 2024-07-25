import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  CustomFormTextField({
    super.key,
    required this.hint,
    required this.obscureText,
    required this.text,
    this.onChanged,
    required this.isSignup,
  });

  final String hint;
  bool obscureText;
  final String text;
  bool isSignup;
  Function(String)? onChanged;

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;

  Future<UserCredential?> signInUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  bool isValidEmail(String email) {
    return email.contains('@');
  }

  bool isValidPassword(String password) {
    return password.length >= 6 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  Future<bool> hasAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (FirebaseAuth.instance.currentUser != null) {
        return true;
      }
      return false;
    }
  }

  WrongPassword(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return cred;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Account does not exist';
      } else if (e.code == 'wrong-password') {
        return 'Wrong Password';
      } else if (e.code == 'invalid-email') {
        return 'Invalid Email';
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.white,
            ),
            validator: (value) {
              if (widget.text == 'Email') {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!isValidEmail(value) && widget.isSignup == true) {
                  return 'Please enter a valid email';
                }
              } else if (widget.text == 'Password') {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (!isValidPassword(value) && widget.isSignup == true) {
                  return '* Password must be at least 6 characters long.\n* and at least one uppercase letter. \n* and one special character.\n';
                } else if (hasAccount(widget.hint, value) == false &&
                    widget.isSignup == false) {
                  return 'Account does not exist';
                } else if (hasAccount(widget.hint, value) == true &&
                    widget.isSignup == true) {
                  return 'Account already exists';
                } else if (WrongPassword(widget.hint, value) == false &&
                    widget.isSignup == false) {
                  return 'Wrong Password';
                }
              }
              return null;
            },
            controller:
                widget.text == 'Email' ? _emailController : _passwordController,
            onChanged: widget.onChanged,
            cursorColor: const Color.fromARGB(255, 255, 255, 255),
            autocorrect: true,
            obscureText: widget.obscureText,
            
            decoration: InputDecoration(
              suffixIcon: widget.text == 'Password'
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                          widget.obscureText = !widget.obscureText;
                        });
                      },
                      icon: Icon(
                        showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: const Color.fromARGB(255, 30, 30, 30),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 73, 77, 172),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 43, 41, 56),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 43, 41, 56),
                ),
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
              ),
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
              
            ),
          ),
        ),
      ],
    );
  }
}
