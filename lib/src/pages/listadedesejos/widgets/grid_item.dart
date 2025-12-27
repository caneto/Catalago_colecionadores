import 'dart:convert';

import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {

  final CarBaseCollection item;

  const GridItem({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: CatalagoColecionadorTheme.bgCard,
        border: Border.all(color: const Color(0xFF222831)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            flex: 3, // Give image more space
            child: Container(
              color: CatalagoColecionadorTheme.bgCard, 
              width: double.infinity,
              child: item.gallery.isNotEmpty
                  ? Image.memory(
                      base64Decode(item.gallery.first.imageBase64),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                            ),
                          ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nomeMiniatura,
                  style: CatalagoColecionadorTheme.titleSmallStyle.copyWith(
                    color: CatalagoColecionadorTheme.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.marca,
                  style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                    color: CatalagoColecionadorTheme.whiteColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.anoFabricacao.toString(),
                  style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
                    color: CatalagoColecionadorTheme.whiteColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                // Actions
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}