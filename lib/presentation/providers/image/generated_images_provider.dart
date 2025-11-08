import 'package:flutter_gemini/config/gemini/gemini_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'generated_history_provider.dart';
import 'is_generating_provider.dart';

part 'generated_images_provider.g.dart';

@Riverpod(keepAlive: true)
class GeneratedImages extends _$GeneratedImages {
  final GeminiImpl gemini = GeminiImpl();

  late final IsGenerating isGeneratingNotifier;
  late final GeneratedHistory generatedHistoryNotifier;

  String previousPrompt = '';
  List<XFile> previousImages = [];

  @override
  List<String> build() {
    isGeneratingNotifier = ref.read(isGeneratingProvider.notifier);
    generatedHistoryNotifier = ref.read(generatedHistoryProvider.notifier);
    return [];
  }

  void addImage(String imagePath) {
    generatedHistoryNotifier.addToHistory(imagePath);
    state = [...state, imagePath];
  }

  void clearImages() {
    state = [];
  }

  Future<void> generateImages(
    String prompts, {
    List<XFile> images = const [],
  }) async {
    isGeneratingNotifier.setIsGenerating();
    // Simulate image generation delay
    final generatedImagePaths = await gemini.generateImage(
      prompts,
      files: images,
    );
    isGeneratingNotifier.setIsNotGenerating();
    if (generatedImagePaths == null) {
      return;
    }
    previousPrompt = prompts;
    previousImages = images;

    addImage(generatedImagePaths);

    if (state.length == 1) {
      generateImageWithPreviousPrompt();
    }
  }

  Future<void> generateImageWithPreviousPrompt() async {
    if (previousPrompt.isEmpty) return;
    await generateImages(previousPrompt, images: previousImages);
  }
}
