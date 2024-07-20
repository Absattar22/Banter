import 'package:banter/constants.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text('Banter'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
      ),
      body: const Center(
        child: Text('Welcome To Banter' , style: TextStyle(fontSize: 30 , color: Color.fromARGB(255, 255, 255, 255)), 
        )
      ),
    );
  }
}