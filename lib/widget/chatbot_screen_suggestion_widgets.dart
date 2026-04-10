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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Text(
        suggestionText,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}