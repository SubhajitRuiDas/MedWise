import 'package:flutter/material.dart';
import 'package:med_tech_app/repository/rag_model/rag_model_http_function.dart';
import 'package:med_tech_app/utils/show_snackbar.dart';
import 'package:med_tech_app/widget/chat_message_bubble.dart';

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
            child: ListView.builder(
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
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
