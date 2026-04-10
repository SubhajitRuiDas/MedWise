import 'package:flutter/material.dart';
import 'package:med_tech_app/repository/rag_model/rag_model_http_function.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';
import 'package:med_tech_app/widget/chat_message_bubble.dart';
import 'package:med_tech_app/widget/chatbot_screen_suggestion_widgets.dart';

class ChatWithModelScreen extends StatefulWidget {
  const ChatWithModelScreen({super.key});

  @override
  State<ChatWithModelScreen> createState() => _ChatWithModelScreenState();
}

class _ChatWithModelScreenState extends State<ChatWithModelScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Stores messages

  void _sendMessage() async{
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'message': _controller.text.trim(),
        'isMe': true,
      });
    });

    // from here call my rag model function to fetch the data
    showSnackbar(context, "Wait for the response of AI...");
    String ragModelResponse = await askRagModel(_controller.text.trim());
    setState(() {
      _messages.add({
        'message': ragModelResponse,
        'isMe': false,
      });
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: _messages.isEmpty ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/artificial-intelligence.png", height: 200, width: 200,),
                    const SizedBox(height: 20,),
                    const Text(
                      "Ask your query to MedWise AI 🤖",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blueGrey
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Get instant medical insights from AI", textAlign: TextAlign.center, 
                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20,),
                    ChatbotScreenSuggestionWidgets(suggestionText: "💊 Ask about a health issue"),
                    ChatbotScreenSuggestionWidgets(suggestionText: "🤒 Check disease symptoms"),
                    ChatbotScreenSuggestionWidgets(suggestionText: "🥗 Get diet recommendations"),
                  ],
                ),
              ),
            )
            : ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                final msg = _messages[index];
                return ChatMessageBubble(
                  message: msg['message'],
                  isMe: msg['isMe'],
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50.0),
                border: const Border(
                  top: BorderSide(color: Colors.black12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
