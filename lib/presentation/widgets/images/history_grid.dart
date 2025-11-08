import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/image/generated_history_provider.dart';
import '../../providers/image/selected_image_provider.dart';

class HistoryGrid extends ConsumerWidget {
  const HistoryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generatedHistory = ref.watch(generatedHistoryProvider);
    final selectedImage = ref.watch(selectedImageProvider);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: generatedHistory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            ref
                .read(selectedImageProvider.notifier)
                .setSelectedImage(generatedHistory[index]);
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedImage == generatedHistory[index]
                    ? Colors.blue
                    : Colors.grey.shade100,
                width: selectedImage == generatedHistory[index] ? 4 : 2,
              ),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(generatedHistory[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
