import 'dart:io';

import 'package:flutter/material.dart';

// Image gallery with selectable image
class MiniatureGallery extends StatelessWidget {
  final List<String> images;

  const MiniatureGallery({super.key, required this.images});

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
                return Padding(
                  padding: EdgeInsets.only(
                    right: i == images.length - 1 ? 0 : 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: itemSize,
                      height: itemSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF0D40A6),
                          width: 1.5,
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
                      child: images[i].startsWith('assets/')
                          ? Image.asset(
                              images[i],
                              width: itemSize,
                              height: itemSize,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, _, __) => Container(
                                color: const Color(0xFF332022),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.white24,
                                  size: 38,
                                ),
                              ),
                            )
                          : Image.file(
                              File(images[i]),
                              width: itemSize,
                              height: itemSize,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, _, __) => Container(
                                color: const Color(0xFF332022),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.white24,
                                  size: 38,
                                ),
                              ),
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
}
