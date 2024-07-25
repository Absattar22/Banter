import 'package:flutter/material.dart';

class OtherSigninOptionButton extends StatelessWidget {
  const OtherSigninOptionButton(
      {super.key, this.onTap, required this.img, required this.text});

  final VoidCallback? onTap;
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 395,
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(
              color: Color.fromARGB(255, 100, 100, 100),
            ),
          ),
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 30, 30, 30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                img,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
