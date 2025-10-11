import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiImpl {
  final Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['ENDPOINT_API'] ?? ''));

  Future<String> getResponse(String prompt) async {
    final body = {'prompt': prompt};
    try {
      final response = await dio.post(
        '/basic-prompt',
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return response.data['response'] ?? 'No response from Gemini.';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}