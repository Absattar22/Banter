import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

Widget YourAvatarBuilder(
      ChatUser user, Function? onTap, Function? onLongPress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Image.asset(
          'assets/images/google.png',
          width: 30,
          height: 50,
        ),
      ),
    );
  }