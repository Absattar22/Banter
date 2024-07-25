import 'dart:convert';

import 'package:banter/services/chat_service.dart';
import 'package:banter/widgets/avatar_builder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:banter/constants.dart';
import 'package:banter/screens/sign_in_screen.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyAADv208IreRY-_jHksI-bFfrVY9ajtWbI';

  ChatUser myself = ChatUser(
    id: '1',
    firstName: 'Zeyad',
    lastName: 'Abdelsattar',
  );

  ChatUser gemini = ChatUser(
    id: '2',
    firstName: 'Google',
    lastName: 'Gemini',
  );
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> typing = <ChatUser>[];

  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = ChatService(
      url: url,
      myself: myself,
      gemini: gemini,
    );
  }

  void updateState(
      List<ChatMessage> updatedMessages, List<ChatUser> updatedTyping) {
    setState(() {
      messages = updatedMessages;
      typing = updatedTyping;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              width: 70,
              height: 70,
            ),
            const Text(
              'Banter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              bool? confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'LOG OUT',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
              if (confirmLogout == true) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.id,
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: myself,
        onSend: (ChatMessage m) {
          chatService.getdata(m, messages, typing, updateState);
        },
        messages: messages,
        inputOptions: const InputOptions(
          inputDecoration: InputDecoration(
            counterStyle: TextStyle(
              color: Colors.white,
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 0, 0, 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            suffixIcon: Icon(
              Icons.attach_file_rounded,
              color: Colors.white,
            ),
            hintText: 'Type a message...',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          alwaysShowSend: true,
          cursorStyle: CursorStyle(
            color: Color.fromARGB(255, 1, 1, 1),
            width: 2,
          ),
          inputTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        messageOptions: const MessageOptions(
          containerColor: Color.fromARGB(255, 203, 197, 197),
          borderRadius: 20.0,
          showCurrentUserAvatar: false,
          showTime: true,
          currentUserContainerColor: Color.fromARGB(255, 34, 171, 221),
          currentUserTextColor: Color.fromARGB(255, 255, 255, 255),
          avatarBuilder: YourAvatarBuilder,
        ),
      ),
    );
  }
}
