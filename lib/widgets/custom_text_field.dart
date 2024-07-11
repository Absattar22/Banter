import 'dart:math';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    required this.obscureText,
    required this.text,
    this.onChanged,
  });

  final String hint;
  final bool obscureText;
  final String text;

  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            text,
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
              if (value!.isEmpty) {
                return 'This field is required';
              } else if (text == 'Email' && !value.contains('@')) {
                return 'Please Enter a valid Email';
              } else if (text == 'Password' && value.length < 6) {
                return 'Password must be at least 6 characters';
              } else if (text == 'Password' &&
                  !value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one uppercase letter';
              } else if (text == 'Password' &&
                  !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return 'Password must contain at least one special character';
              } else if (text == 'Password' &&
                  !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
                  !value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain one uppercase letter\nand one special character';
              }
            },
            onChanged: onChanged,
            cursorColor: const Color.fromARGB(255, 255, 255, 255),
            autocorrect: true,
            obscureText: obscureText,
            decoration: InputDecoration(
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
              hintText: hint,
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
