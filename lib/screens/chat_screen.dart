import 'package:banter/constants.dart';
import 'package:banter/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Banter'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Are you sure you want to log out?'),
                  action: SnackBarAction(
                    label: 'Log Out',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignInScreen.id,
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Chat Screen',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
