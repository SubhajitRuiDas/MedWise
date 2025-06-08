import 'dart:convert';

import 'package:med_tech_app/utils/constant_api_key.dart';
import 'package:http/http.dart' as http;

class GeminiApiService {
  static Future<String> askGeminiAI(String prompt) async{
    try {
      final uri = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiApiKey");

      final Map<String, dynamic> requestBody = {
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": prompt}
            ]
          }
        ],
        "generationConfig": {
          "temperature": 0.5,
          "topK": 40,
          "topP": 0.95,
          "maxOutputTokens": 1024,
          "responseMimeType": "text/plain"
        }
      };

      final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
      );

      if(response.statusCode != 200){
        throw Exception("Failed to get response = ${response.statusCode}");
      }

      final responseData = jsonDecode(response.body);
    final candidates = responseData["candidates"] as List<dynamic>?;
    if(candidates == null || candidates.isEmpty){
      throw Exception("candidate response is empty");
    }

    final content = candidates[0]["content"];
    final parts = content["parts"] as List<dynamic>?;

    if(parts == null || parts.isEmpty){
      throw Exception("no response found");
    }
    return parts[0]["text"] ?? "No response text found.";
    } catch (e) {
      print(e.toString());
      return "Failed to fetch AI response";
    }
  }
}

// Dio dio = Dio();

    //   // Prepare the request body
    //   final Map<String, dynamic> requestBody = {
    //     "contents": messages.map((message) => message.toMap()).toList(),
    //     "generationConfig": {
    //       "temperature": 0.5,
    //       "topK": 40,
    //       "topP": 0.95,
    //       "maxOutputTokens": 8192,
    //       "responseMimeType": "text/plain"
    //     }
    //   };

    //   print("Request Data: ${jsonEncode(requestBody)}");

    //   final response = await dio.post(
    //     "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiApiKey",
    //     data: requestBody,
    //     options: Options(headers: {
    //       "Content-Type": "application/json",
    //     }),
    //   );

    //   print("Response Data: ${response.data}");

    //   // Process the response
    //   final List<dynamic>? candidates = response.data["candidates"];
    //   if (candidates == null || candidates.isEmpty) {
    //     throw Exception("No candidates found in response.");
    //   }

    //   // Extract the content from the first candidate
    //   final Map<String, dynamic> content = candidates[0]["content"];
    //   final List<dynamic> parts = content["parts"] ?? [];

    //   // Convert to ChatMessageModel
    //   List<ChatMessageModel> responseMessages = [
    //     ChatMessageModel(
    //       role: content["role"] ?? "model",
    //       parts: parts
    //           .map((part) => ChatPartsModel(text: part["text"] ?? ""))
    //           .toList(),
    //     )
    //   ];

    //   return responseMessages;