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
  Stream<String> getResponseStream(String prompt) async* {
    //TODO: tener presente que enviaremos imagenes tambien
    final body = {'prompt': prompt};
    try {
      final response = await _dio.post('/basic-prompt-stream', data: jsonEncode(body), options: Options(responseType: ResponseType.stream));
      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';
      await for (var chunk in stream) {
        buffer += utf8.decode(chunk, allowMalformed: true);
        // int index;
        // while ((index = buffer.indexOf('\n')) != -1) {
        //   final line = buffer.substring(0, index).trim();
        //   if (line.isNotEmpty) {
        //     yield line;
        //   }
        //   buffer = buffer.substring(index + 1);
        // }
        yield buffer;
      }
      // yield* response.data.stream.map((event) => event.toString());
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
