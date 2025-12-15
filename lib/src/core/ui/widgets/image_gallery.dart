import 'dart:convert';
import 'dart:io';

import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

// Image gallery with selectable image
class ImageGallery extends StatelessWidget {
  final List<String> images;
  final int? selectedIndex;
  final ValueChanged<int>? onImageSelected;

  const ImageGallery({
    super.key,
    required this.images,
    this.selectedIndex,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double itemSize = 180.0;

    return Column(
      children: [
        SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: itemSize,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(images.length, (i) {
                return GestureDetector(
                  onTap: () => onImageSelected?.call(i),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i == images.length - 1 ? 0 : 12,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        width: itemSize,
                        height: itemSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedIndex == i
                                ? CatalagoColecionadorTheme.orangeColor
                                : CatalagoColecionadorTheme.bgInputAccent,
                            width: selectedIndex == i ? 4.0 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.09,
                              ), // corrigido
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: _buildImage(images[i], itemSize),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 4),
      ],
    );
  }

  Widget _buildImage(String imageSource, double size) {
    if (imageSource.startsWith('assets/')) {
      return Image.asset(
        imageSource,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (ctx, _, __) => _buildErrorPlaceholder(),
      );
    } else if (imageSource.startsWith('/') ||
        imageSource.startsWith('file://')) {
      return Image.file(
        File(imageSource),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (ctx, _, __) => _buildErrorPlaceholder(),
      );
    } else {
      try {
        return Image.memory(
          base64Decode(imageSource),
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (ctx, _, __) => _buildErrorPlaceholder(),
        );
      } catch (e) {
        return _buildErrorPlaceholder();
      }
    }
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: const Color(0xFF332022),
      alignment: Alignment.center,
      child: const Icon(
        Icons.broken_image_outlined,
        color: Colors.white24,
        size: 38,
      ),
    );
  }
}
