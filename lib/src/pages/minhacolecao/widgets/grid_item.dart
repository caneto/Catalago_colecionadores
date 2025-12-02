import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/database/isar_models/car_collection.dart';

class GridItem extends StatelessWidget {
  final CarCollection item;
  final Color surface;
  final Color brandColor;
  final Color modelColor;

  const GridItem({
    super.key,
    required this.item,
    required this.surface,
    required this.brandColor,
    required this.modelColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed('/miniatura_details', arguments: item.id);
      },
      child: Semantics(
        label: '${item.marca}, ${item.nomeMiniatura}',
        child: Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: item.imagePath != null && item.imagePath!.isNotEmpty
                      ? Image.file(
                          File(item.imagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stack) =>
                              Container(color: Colors.grey.shade300),
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.marca,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.18,
                        letterSpacing: -0.01,
                        color: brandColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.nomeMiniatura,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.12,
                        letterSpacing: -0.01,
                        color: modelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
