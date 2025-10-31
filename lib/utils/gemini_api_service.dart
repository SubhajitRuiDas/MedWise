import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_tech_app/utils/constant_api_key.dart';

class GeminiApiService {
  static Future<String> askGeminiAI(String prompt) async {
    try {
      final uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$geminiApiKey",
      );

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
          "maxOutputTokens": 2048,
          "responseMimeType": "text/plain"
        }
      };

      print("Sending request to Gemini...");
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      print("Gemini raw response: ${response.body}");
      if (response.statusCode != 200) {
        throw Exception("Failed: ${response.statusCode}");
      }

      final responseData = jsonDecode(response.body);
      final candidates = responseData["candidates"] as List<dynamic>?;

      if (candidates == null || candidates.isEmpty) {
        throw Exception("No candidates found in response.");
      }
      final content = candidates[0]["content"];
      final parts = content["parts"] as List<dynamic>?;
      if (parts == null || parts.isEmpty) {
        throw Exception("No response parts found.");
      }

      final text = parts[0]["text"];
      if (text == null || text.isEmpty) {
        throw Exception("Empty response text.");
      }
      print("Api response answer: $text");
      return text;
    } catch (e) {
      print("Error from gemini api: $e");
      return "Error: $e";
    }
  }
}
