import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.obscureText,
      required this.text});

  final String hint;
  final bool obscureText;
  final String text;
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
          child: TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
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
