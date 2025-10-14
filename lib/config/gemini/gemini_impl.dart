import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

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

  Stream<String> getResponseStream(
    String prompt, {
    List<XFile> files = const [],
  }) async* {
    yield* _getStreamResponse(
      prompt: prompt,
      endpoint: '/basic-prompt-stream',
      files: files,
    );
  }

  Stream<String> getChatStream(
    String prompt,
    String chatId, {
    List<XFile> files = const [],
  }) async* {
    yield* _getStreamResponse(
      prompt: prompt,
      endpoint: '/chat-stream',
      formFields: {'chatId': chatId},
      files: files,
    );
  }

  // Emitir el stream de informacion
  Stream<String> _getStreamResponse({
    required String prompt,
    required String endpoint,
    Map<String, dynamic> formFields = const {},
    List<XFile> files = const [],
  }) async* {
    final formData = FormData();
    formData.fields.add(MapEntry('prompt', prompt));
    for (final entry in formFields.entries) {
      formData.fields.add(MapEntry(entry.key, entry.value));
    }
    for (var file in files) {
      formData.files.add(
        MapEntry(
          'files',
          await MultipartFile.fromFile(file.path, filename: file.name),
        ),
      );
    }
    try {
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(responseType: ResponseType.stream),
      );
      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';
      await for (var chunk in stream) {
        buffer += utf8.decode(chunk, allowMalformed: true);
        yield buffer;
      }
    } catch (e) {
      yield 'Error: $e';
    }
  }
}
