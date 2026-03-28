import 'package:flutter/material.dart';

class ChatbotScreenSuggestionWidgets extends StatelessWidget{
  final String suggestionText;
  const ChatbotScreenSuggestionWidgets({super.key, required this.suggestionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(6),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        suggestionText,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}