import 'dart:convert';

import 'package:http/http.dart' as http;
Future<String> askRagModel(String userMessageText) async{
  final url = Uri.parse("http://127.0.0.1:8000/ask");
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"query": userMessageText}),
  );

  if(response.statusCode == 200){
    final ragModelResponseData = jsonDecode(response.body);
    return ragModelResponseData["response"] ?? "No response from RAG model";
  } else {
    throw Exception("Failed to process RAG model API, check code");
  }
}