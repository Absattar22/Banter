import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatService {
  final String url;
  final ChatUser myself;
  final ChatUser gemini;

  ChatService({required this.url, required this.myself, required this.gemini});
  

  Future<void> getdata(ChatMessage m, List<ChatMessage> messages, List<ChatUser> typing, Function(List<ChatMessage>, List<ChatUser>) updateState) async {
    messages.insert(0, m);
    if (m.user.id == myself.id) {
      typing = [gemini];
    } else {
      typing = [myself];
    }
    updateState(messages, typing);

    await Future.delayed(const Duration(seconds: 2));

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '{"contents":[{"parts":[{"text":"${m.text}"}]}]}',
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text'];
      messages.insert(
        0,
        ChatMessage(
          text: data,
          user: gemini,
          createdAt: DateTime.now(),
        ),
      );
      typing = [];
      updateState(messages, typing);
    } else {
          void showSnackbar(BuildContext context, String message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          }
        }
  }
}