import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiImpl {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['ENDPOINT_API'] ?? ''));

  Future<String> getResponse(String prompt) async {
    final body = {'prompt': prompt};
    try {
      final response = await _dio.post('/basic-prompt', data: jsonEncode(body));

      return response.data;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
