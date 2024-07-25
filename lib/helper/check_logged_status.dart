import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banter/screens/chat_screen.dart';
import 'package:banter/screens/sign_in_screen.dart';

class CheckAuth extends StatefulWidget {
  static const String id = 'check_auth';
  
  const CheckAuth({super.key});

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    setState(() {
      _isLoggedIn = isLoggedIn ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? const ChatScreen() : const SignInScreen();
  }
}