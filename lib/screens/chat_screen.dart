import 'package:banter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static String id = 'chatScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text('Welcome To Banter' , style: TextStyle(fontSize: 30 , color: Color.fromARGB(255, 255, 255, 255)), 
        )
      ),
    );
  }
}