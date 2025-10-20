import 'dart:convert';

import 'package:http/http.dart' as http;
Future<String> askRagModel(String userMessageText) async{
  final url = Uri.parse("http://34.100.167.230:8000/rag/med/retrieve");  // ata demo url raklam

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"query": userMessageText, "session_id": "1"}),
  );

  if(response.statusCode == 200){
    final ragModelResponseData = jsonDecode(response.body);
    return ragModelResponseData["response"] ?? "No response from RAG model";
  } else {
    throw Exception("Failed to process RAG model API, check code");
  }
}