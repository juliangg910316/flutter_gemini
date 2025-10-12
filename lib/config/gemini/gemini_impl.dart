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
    final formData = FormData();
    formData.fields.add(MapEntry('prompt', prompt));
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
        '/basic-prompt-stream',
        data: formData,
        options: Options(responseType: ResponseType.stream),
      );
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
